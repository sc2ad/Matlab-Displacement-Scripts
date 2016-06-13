#include "C:\Program Files\MATLAB\R2013a\extern\include\mex.h"
#include "C:\Program Files\MATLAB\R2013a\extern\include\matrix.h"
#include "uc480.h"
#include "uc480_deprecated.h"
// Make sure the version shown above matches your version of MATLAB

void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
    /* Check for proper number of arguments */
    if (nrhs != 0) 
    { 
       mexErrMsgTxt("No inputs!"); 
    }
    else if (nlhs != 2) 
    { 
       mexErrMsgTxt("Whoa, big guy.  Give me 2 outputs"); 
    } 

    //Initialize camera and get the memory handle
    int error = 0;
    plhs[0] = mxCreateNumericMatrix(1,1,mxUINT32_CLASS,mxREAL); //camera handle is 1st output
    HCAM *pcam  = (HCAM *)mxGetPr(plhs[0]);

    error = is_InitCamera(pcam,NULL);
    if (error != IS_SUCCESS) 
    {
       mexErrMsgTxt("Error initializing camera; Not connected or already open"); 
    }
    HCAM cam = *pcam;
 
    //Get sensor info, principally for the CCD size 
    SENSORINFO sInfo;
    int nX = 0;
    int nY = 0;
    error = is_GetSensorInfo(cam, &sInfo);  
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error getting sensor info"); 
    }
	nX = sInfo.nMaxWidth;
	nY = sInfo.nMaxHeight;

    int	m_nColorMode;	// Y8/RGB16/RGB24/REG32
    int	m_nBitsPerPixel;// number of bits needed store one pixel
    
    //Set up the color depth to the current windows setting    		
     m_nColorMode = IS_CM_SENSOR_RAW8;
     m_nBitsPerPixel = 8;
     mexPrintf("%d, %d\n",m_nColorMode, m_nBitsPerPixel);
     error = is_SetColorMode(cam, m_nColorMode);
     if (error != IS_SUCCESS) 
     { 
         mexErrMsgTxt("Error setting color mode"); 
     }


    char *p_image = NULL;
    int ID = 0;
    error = is_AllocImageMem(cam,nX,nY,m_nBitsPerPixel,&p_image, &ID);
    if (error != IS_SUCCESS) 
    { 
        mexErrMsgTxt("Error allocating image memory"); 
    }
    
    //Activate image memory
    error = is_SetImageMem(cam,p_image,ID);
    if (error !=IS_SUCCESS)
    {
        mexErrMsgTxt("Error activating image memory"); 
    }
    
	error = is_SetImageSize(cam,nX,nY);   
    if (error !=IS_SUCCESS)
    {   
       mexErrMsgTxt("Error setting image size");  
    }
    error = is_SetDisplayMode(cam, IS_SET_DM_DIB);
    if (error !=IS_SUCCESS)
    {   
       mexErrMsgTxt("Error setting display mode");  
    }
    		    
    
// // // // // // // // // // // // // // // // // // // // // // //    

    //Disable auto parameters
    double pval1 = 0;
    double pval2 = 0;
 
    error = is_SetAutoParameter (cam,  IS_SET_ENABLE_AUTO_GAIN, &pval1, &pval2);
    if (error !=IS_SUCCESS)
    {   
        mexErrMsgTxt("IS_SET_ENABLE_AUTO_GAIN error");  
    }
     error = is_SetAutoParameter (cam,  IS_SET_ENABLE_AUTO_SHUTTER, &pval1, &pval2);
    if (error !=IS_SUCCESS)
    {   
        mexErrMsgTxt("IS_SET_ENABLE_AUTO_SHUTTER error");  
    }
    error = is_SetAutoParameter (cam,  IS_SET_ENABLE_AUTO_FRAMERATE, &pval1, &pval2);
    if (error !=IS_SUCCESS)
    {   
        mexErrMsgTxt("IS_SET_ENABLE_AUTO_FRAMERATE error");  
    }
    
// // // // // // // // // // // // // // // // // // // // // // //    

    
    // Set gain levels for all channels to 0%
    error = is_SetHardwareGain (cam, 0, 0, 0, 0);
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error setting gain to minimum"); 
    }

    // Disable gain boost feature 
    error = is_SetGainBoost (cam, IS_SET_GAINBOOST_OFF);
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error turning off gainboost"); 
    }
     
    int nRange[3];
    ZeroMemory(nRange,sizeof(nRange));

    // Set pixel clock to midrange
    error = is_PixelClock(cam,IS_PIXELCLOCK_CMD_GET_RANGE, (void*)&nRange, sizeof(nRange));
    int nMin = nRange[0];
    int nMax = nRange[1];
    int nInc = nRange[2];
    int nMid = (nMin+nMax)/2;
    int nRet = is_PixelClock(cam, IS_PIXELCLOCK_CMD_SET, (void*)&nMid, sizeof(nMid));
    mexPrintf("Pixel clock set to: %d \n", nMid);
     
    // Set frame rate to minimum allowable
    double min_frame_time,  max_frame_time,  frame_time_interval, fps_actual;
    error = is_GetFrameTimeRange (cam, &min_frame_time, &max_frame_time, &frame_time_interval);
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error getting frame rate info"); 
    }    
    error = is_SetFrameRate (cam, 1/min_frame_time, &fps_actual);
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error setting frame rate"); 
    }
     mexPrintf("Frame rate set to (fps): %f \n", fps_actual);
    
    // Set exposure time
    double min=17.28;
    nRet = is_Exposure(cam,IS_EXPOSURE_CMD_SET_EXPOSURE,(void*)&min,sizeof(min));
    mexPrintf("Exposure set to: %f \n", min);
    
    // Sleep to allow settings to update
    Sleep(500);
    
// // // // // // // // // // // // // // // // // // // // // // //    

    
    //Use freeze video to initiate frame grab
    error = is_FreezeVideo( cam, IS_WAIT );
    if (error !=IS_SUCCESS)
    {   
        mexPrintf("%d\n",error);
        mexErrMsgTxt("Error freezing frame");  
    }
    
    // Create matlab image structure with "image" field of uint8 data type,
    //"pointer" field with int-valued pointer to the image buffer,
    // and "ID" field with int-valued ID for this buffer.
    const char *field_names[] = {"image", "pointer", "ID"};
    mwSize dims[2] = {1, 1};
    
    //Create frame structure
    plhs[1] = mxCreateStructArray(2, dims, 3, field_names);
    int image_field = mxGetFieldNumber(plhs[1],"image");
    int pointer_field = mxGetFieldNumber(plhs[1],"pointer");
    int ID_field = mxGetFieldNumber(plhs[1],"ID");

    //Create image array for frame struct
    mxArray *p_output_image = mxCreateNumericMatrix(nX, nY, mxUINT8_CLASS, mxREAL);
    char *p_output = (char *)mxGetPr(p_output_image);           
    error =  is_CopyImageMem(cam, p_image, ID, p_output);
    if (error !=IS_SUCCESS)
    {   
        mexPrintf("%d\n",error);
        mexErrMsgTxt("Error copying image data to output");  
    }
    
    //Set image data in frame struct
    mxSetFieldByNumber(plhs[1],0,image_field, p_output_image); 
    
    //Create image pointer field of frame struct
    mxArray *ppointer_field = mxCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
    mxSetFieldByNumber(plhs[1],0,pointer_field,ppointer_field); 
    
    //Set the pointer field to contain image array adderss 
    int *ppointer = (int *)mxGetPr(ppointer_field);
    *ppointer = (int)p_image;

    // Create ID field of frame struct
    mxArray *pID_field = mxCreateNumericMatrix(1, 1, mxINT32_CLASS,mxREAL);
    mxSetFieldByNumber(plhs[1],0,ID_field,pID_field); 
    
 	// Set ID pointer to ID field
    int *pID = (int *)mxGetPr(pID_field);
    *pID = ID;
    
    return;   
}
