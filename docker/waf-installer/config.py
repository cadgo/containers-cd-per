from sqlalchemy import create_engine
from pathlib import Path

# Database configuration
engine = create_engine(rf"sqlite:///waf_comparison.db")

# Data set paths
LEGITIMATE_URL_PATH = "https://downloads.openappsec.io/waf-comparison-project/legitimate.zip"
MALICIOUS_URL_PATH = "https://downloads.openappsec.io/waf-comparison-project/malicious.zip"

# Data set Path
DATA_PATH = Path('Data')
LEGITIMATE_PATH = DATA_PATH / 'Legitimate'
MALICIOUS_PATH = DATA_PATH / 'Malicious'

# WAF configuration
WAFS_DICT = {
    "open-appsec/CloudGuard AppSec - Critical Profile": 'http://testdomain.info',
    "open-appsec/CloudGuard AppSec - Default Profile": 'http://testdomain.info'
}
