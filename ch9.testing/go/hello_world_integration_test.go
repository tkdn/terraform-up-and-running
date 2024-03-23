package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

const dbDirStage = "../live/stg/data-stores/mysql"
const appDirStage = "../live/stg/services/hello-world-app"

func TestHelloWorldAppStage(t *testing.T) {
	t.Parallel()

	// DB
	dbOpts := createDbOpts(t, dbDirStage)
	defer terraform.Destroy(t, dbOpts)
	terraform.InitAndApply(t, dbOpts)

	// App
	appOpts := createAppOpts(dbOpts, appDirStage)
	defer terraform.Destroy(t, appOpts)
	terraform.InitAndApply(t, appOpts)

	// Check App
	validateApp(t, appOpts)
}

func validateApp(t *testing.T, appOpts *terraform.Options) {
	albDnsName := terraform.OutputRequired(t, appOpts, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDnsName)

	maxRetries := 10
	retryInterval := 10 * time.Second

	http_helper.HttpGetWithRetryWithCustomValidation(
		t,
		url,
		nil,
		maxRetries,
		retryInterval,
		func(status int, body string) bool {
			return status == 200 && strings.Contains(body, "Hello, World")
		},
	)
}

func createAppOpts(dbOpts *terraform.Options, appDirStage string) *terraform.Options {
	return &terraform.Options{
		TerraformDir: appDirStage,
		Vars: map[string]interface{}{
			"db_remote_state_bucket": dbOpts.BackendConfig["bucket"],
			"db_remote_state_key":    dbOpts.BackendConfig["key"],
			"environment":            dbOpts.Vars["db_name"],
		},
	}
}

func createDbOpts(t *testing.T, dbDirStage string) *terraform.Options {
	uniqueID := random.UniqueId()

	bucket := "20230323-terraform-testing"
	bucketRegion := "ap-northeast-1"
	dbStateKey := fmt.Sprintf("%s/%s/terrafrom.tfstate", t.Name(), uniqueID)

	return &terraform.Options{
		TerraformDir: dbDirStage,
		Vars: map[string]interface{}{
			"db_name":     fmt.Sprintf("test%s", uniqueID),
			"db_username": "admin",
			"db_password": "passw0rd",
		},
		BackendConfig: map[string]interface{}{
			"bucket":  bucket,
			"region":  bucketRegion,
			"key":     dbStateKey,
			"encrypt": true,
		},
	}
}
