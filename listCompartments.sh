#!/bin/bash
. ~/.bash_profile
oci iam compartment list --output table --query "data [*].{Name:name, Description:description, OCID:id}" --compartment-id-in-subtree true
