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
