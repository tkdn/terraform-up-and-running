package test

import (
	"fmt"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAlbExample(t *testing.T) {
	t.Parallel()

	opts := &terraform.Options{
		TerraformDir: "../examples/alb",
		Vars: map[string]interface{}{
			"alb_name": fmt.Sprintf("test-%s", random.UniqueId()),
		},
	}
	defer terraform.Destroy(t, opts)

	terraform.InitAndApply(t, opts)

	// 出力されることをテスト
	albDnsName := terraform.OutputRequired(t, opts, "alb_dns_name")
	url := fmt.Sprintf("http://%s", albDnsName)

	// ALBデフォルトアクションが動作し404を返すことをテスト
	wantStatus := 404
	wantBody := "404: page not found"
	maxRetries := 10
	retryInterval := 10 * time.Second
	http_helper.HttpGetWithRetry(
		t,
		url,
		nil,
		wantStatus,
		wantBody,
		maxRetries,
		retryInterval,
	)
}
