:: Shares Malwarebytes folders for scan and detection results, for scripted retrieval, parsing, and reporting


net share MBAMScanResults="C:\ProgramData\Malwarebytes\MBAMService\ScanResults" /GRANT:Everyone,FULL

net share MBAMQuarantine="C:\ProgramData\Malwarebytes\MBAMService\Quarantine" /GRANT:Everyone,FULL

net share MBAMRtpDetections="C:\ProgramData\Malwarebytes\MBAMService\RtpDetections" /GRANT:Everyone,FULL

net share MBAMArwDetections="C:\ProgramData\Malwarebytes\MBAMService\ArwDetections" /GRANT:Everyone,FULL

net share MBAMAeDetections="C:\ProgramData\Malwarebytes\MBAMService\AeDetections" /GRANT:Everyone,FULL








