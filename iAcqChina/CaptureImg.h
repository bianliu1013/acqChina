#ifndef _TAURUSACQ_CAPTUREIMAG_H_
#define _TAURUSACQ_CAPTUREIMAG_H_

#define CAPTUREIMAGE            (CaptureImg::GetInstance())

class CaptureImg
{
public:
    static CaptureImg *GetInstance();
    static void FreeInstance();
    
    static void SetPatientImgPath(const char* patientImgPath);
	static bool CaptureImgRequest();
	static bool DownloadImageFromHP(const char* name);

private:
    CaptureImg();
	~CaptureImg();
    
private:
    static CaptureImg             *m_sInStance;
    static char                   m_szPatientImgPath[512];

};

#endif