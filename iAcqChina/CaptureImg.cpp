#include "CaptureImg.h"
//#include "../Communicate/EventQueue/EventDefs.h"
//#include "../Communicate/EventQueue/EventQueue.h"
//#include "../Communicate/CommManager.h"
//#include "../Communicate/MsgSender/CS1500MsgSender.h"
//#include "../Communicate/MsgReceiver/CS1500MsgReceiver.h"

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lib/Chilkat/CkFtp2.h"

//using namespace Taurusacq;

CaptureImg *CaptureImg::m_sInStance = NULL;
char CaptureImg::m_szPatientImgPath[512] = {0};


CaptureImg::CaptureImg()
{
    ;
}

CaptureImg::~CaptureImg()
{
	;
}

CaptureImg *CaptureImg::GetInstance() {
    if (!m_sInStance) {
        m_sInStance = new CaptureImg;
    }
    
    return m_sInStance;
}

void CaptureImg::FreeInstance() {
    if (m_sInStance) {
        delete m_sInStance;
        m_sInStance = NULL;
    }
}

void CaptureImg::SetPatientImgPath(const char *patientImgPath)
{
    strcpy(m_szPatientImgPath, patientImgPath);
}

bool CaptureImg::CaptureImgRequest()
{
	// TODO return MSGSENDER->SendCaptureImgRequest();
    return true;
}

bool CaptureImg::DownloadImageFromHP(const char* name)
{
    if (NULL == name) {
        return false;
    }
	CkFtp2 ftp;
	bool success = false;

	// Any string unlocks the component for the 1st 30-days.
	success = ftp.UnlockComponent("Anything for 30-day trial");
	if (success != true) {
		return false;
	}

	ftp.put_Hostname("127.0.0.1");
	ftp.put_Username("123");
	ftp.put_Password("123");

	// The default data transfer mode is "Active" as opposed to "Passive".

	// Connect and login to the FTP server.
	success = ftp.Connect();
	if (success != true) {
		return false;
	}

	// Change to the remote directory where the file is located.
	// This step is only necessary if the file is not in the root directory
	// for the FTP account.
	success = ftp.ChangeRemoteDir("/images");
	if (success != true) {
		return false;
	}
    
	// Download a file.
	char remoteFilename[128] = {0};
    char localFileName[512] = {0};
    
    strcpy(remoteFilename, name);
    strcpy(localFileName, m_szPatientImgPath);
    strcat(localFileName, name);
    
    memcpy(remoteFilename, name, strlen(name));

	success = ftp.GetFile(remoteFilename,localFileName);
	if (success != true) {
        char errorText[512] = {0};
        memcpy(errorText, ftp.lastErrorText(), 512);
		return false;
	}

	ftp.Disconnect();
	return success;
}