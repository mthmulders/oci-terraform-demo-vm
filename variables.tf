variable "user_ocid" {}             # OCID of your tenancy
variable "tenancy_ocid" {}          # OCID of the user calling the API
variable "fingerprint" {}           # Fingerprint for the key pair being used
variable "private_key_path" {}      # The path (including filename) of the private key stored on your computer
variable "private_key_password" {}  # Passphrase used for the key, if it is encrypted.
variable "region" {}                # An Oracle Cloud Infrastructure region

variable "demo_compartment_ocid" {} # OCID of the Comparment where the VM will live
variable "ssh_authorized_key" {}    # Public OpenSSH key that will be authorised to log on to the machine. 