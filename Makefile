GCP_PROJECT=kiyocy24

.phony: encrypt_credential
encrypt_credential:
	gcloud kms encrypt \
    --location "asia-northeast1" \
    --keyring "urchecker" \
    --key "infra" \
    --plaintext-file ./terraform/credential.json \
    --ciphertext-file ./terraform/encrypted/credential.json.enc

.phony: decrypt_credential
decrypt_credential:
	gcloud kms decrypt \
    --location "asia-northeast1" \
    --keyring "urchecker" \
    --key "infra" \
    --plaintext-file ./terraform/credential.json \
    --ciphertext-file ./terraform/encrypted/credential.json.enc

.phony: encrypt_tfvars
encrypt_tfvars:
	gcloud kms encrypt \
    --location "asia-northeast1" \
    --keyring "urchecker" \
    --key "infra" \
    --plaintext-file ./terraform/terraform.tfvars \
    --ciphertext-file ./terraform/encrypted/terraform.tfvars.enc

.phony: decrypt_tfvars
decrypt_tfvars:
	gcloud kms decrypt \
    --location "asia-northeast1" \
    --keyring "urchecker" \
    --key "infra" \
    --plaintext-file ./terraform/terraform.tfvars \
    --ciphertext-file ./terraform/encrypted/terraform.tfvars.enc
