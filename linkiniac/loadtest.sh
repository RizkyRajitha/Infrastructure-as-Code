#!/bin/bash

ab -v 4 -n 500 -c 4 -p loginpost -T "application/json"  http://34.206.1.42/api/login > loadtest1.log &
ab -v 4 -n 500 -c 4 -p insertpost -T "application/json" -H "Cookie: redirect_to=%2F; linkin.auth=eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiUEJFUzItSFMyNTYrQTEyOEtXIiwicDJjIjoyNDg3LCJwMnMiOiJXQWlNUTZYdUNnYi1NcnZ6bV9RYXFnIn0.J336bcdhO8dPwufI0peTq-pbssREGHPEcVfv4zaSCJU_pGZa4gR49g.-_ARuYjKL6HkZtymhppOnA.oqViDspKbKobO4xvT4d6IptEYmQDVxL1Eb8wChed05o8L1rFe8ywEyKaWhxFujSMygK0Kienay6D-aUuZYJWExxtv4kfawt4RlaFZx82LrcXBUsrPKy3nXQoZMB30deaLCKx2ff4kpC2UA4SroKAK47AqB-jQWBp5N_YNyva7iw._5bJMIYoPwX7JqKASSKk7w" http://34.206.1.42/api/insertpagelinks > loadtest2.log &
ab -v 4 -n 2000 -c 20 -p updatepost -T "application/json" -H "Cookie: redirect_to=%2F; linkin.auth=eyJlbmMiOiJBMTI4Q0JDLUhTMjU2IiwiYWxnIjoiUEJFUzItSFMyNTYrQTEyOEtXIiwicDJjIjoyNDg3LCJwMnMiOiJXQWlNUTZYdUNnYi1NcnZ6bV9RYXFnIn0.J336bcdhO8dPwufI0peTq-pbssREGHPEcVfv4zaSCJU_pGZa4gR49g.-_ARuYjKL6HkZtymhppOnA.oqViDspKbKobO4xvT4d6IptEYmQDVxL1Eb8wChed05o8L1rFe8ywEyKaWhxFujSMygK0Kienay6D-aUuZYJWExxtv4kfawt4RlaFZx82LrcXBUsrPKy3nXQoZMB30deaLCKx2ff4kpC2UA4SroKAK47AqB-jQWBp5N_YNyva7iw._5bJMIYoPwX7JqKASSKk7w" http://34.206.1.42/api/updatepagedata > loadtest3.log &
