#!/bin/bash

SCRIPT_PATH=$(dirname "$(realpath $0)")

export PROJECT_ID=iron-axon-459615-n2
export ACCELERATOR_TYPE=v5litepod-1
export ZONE=us-central1-a
export RUNTIME_VERSION=v2-alpha-tpuv5-lite
export TPU_NAME=test-node
export NETWORK=test-network
export SUBNET=us-central1-subnet
export STARTUP_SCRIPT_PATH="$SCRIPT_PATH/tpu_vm_startup_script.sh"

gcloud compute tpus tpu-vm create $TPU_NAME \
    --zone=$ZONE \
    --accelerator-type=$ACCELERATOR_TYPE \
    --version=$RUNTIME_VERSION \
    --project=$PROJECT_ID \
    --network=$NETWORK \
    --subnetwork=$SUBNET \
    --spot \
    --metadata-from-file startup-script="$STARTUP_SCRIPT_PATH"
