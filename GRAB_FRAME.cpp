#include "C:\Program Files\MATLAB\R2013a\extern\include\mex.h"
#include "C:\Program Files\MATLAB\R2013a\extern\include\matrix.h"
#include "uc480.h"
// Make sure the version shown above matches your version of MATLAB

void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{        

    /* Check for proper number of arguments */
    if (!(nrhs == 2)) 
    {   
        mexErrMsgTxt("You have to give me two inputs"); 
    } 
    
    if (!mxIsStruct(prhs[1]))
    {
        mexErrMsgTxt("That second input has to be an image structure, you know.");
    }
    
    int error = 0;
    int BitsPerPixel = 8;
    HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
    
    //Freeze the video feed for frame grab to prevent split frames
    error = is_FreezeVideo( cam, IS_WAIT );
    if (error !=IS_SUCCESS)
    {   
       mexErrMsgTxt("Error freezing video");  
    }  
    
    int image_field = mxGetFieldNumber(prhs[1],"image");
    int pointer_field = mxGetFieldNumber(prhs[1],"pointer");
    int ID_field = mxGetFieldNumber(prhs[1],"ID");

    mxArray *p_output_image = mxGetFieldByNumber(prhs[1],0,image_field);
    char *p_output = (char *)mxGetPr(p_output_image);
    mxArray *ppointer_field = mxGetFieldByNumber(prhs[1],0,pointer_field);
    char *p_image = (char *)*(int *)mxGetPr(ppointer_field);
    mxArray *pID_field = mxGetFieldByNumber(prhs[1],0,ID_field);
    int *ID = (int *)mxGetPr(pID_field); 
           
    error =  is_CopyImageMem (cam, p_image, *ID, p_output);
    if (error !=IS_SUCCESS)
    {   
       mexErrMsgTxt("Error copying image data to output");  
    }
    
    //If a variable is supplied on the LHS, use it to output image frame data
    if (nlhs == 1)
    {
        //Get sensor info, principally for the CCD size 
        SENSORINFO sInfo;
        int nX = 0;
        int nY = 0;
        error = is_GetSensorInfo( cam, &sInfo );
        if (error != IS_SUCCESS) 
        {
            mexErrMsgTxt("Error getting sensor info"); 
        }
        
    // nX and nY are sub-region image size in pixels. Make sure they match your OPEN_CAMERA.cpp values
        sInfo.nMaxWidth;
        sInfo.nMaxHeight;

        mxArray *p_output_image_new = mxCreateNumericMatrix(nX, nY, mxUINT8_CLASS, mxREAL);
        p_output = (char *)mxGetPr(p_output_image_new);           
        error =  is_CopyImageMem (cam, p_image, *ID, p_output);
        if (error !=IS_SUCCESS)
        {   
           mexErrMsgTxt("Error copying image data to output");  
        }
        
        //Set mex function output
        plhs[0] = p_output_image_new;
    
    } 
    return;   
}

 
