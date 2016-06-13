#include "C:\Program Files\MATLAB\R2013a\extern\include\mex.h"
#include "C:\Program Files\MATLAB\R2013a\extern\include\matrix.h"
#include "uc480.h"
#include "uc480_deprecated.h"
#include <math.h>

void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
       
    /* Check for proper number of arguments */
    if (!(nrhs == 4) || !(nlhs==0) )
    {   
        mexErrMsgTxt("you have to input camera handle, pixel clock, and exposure interval"); 
    }  

    double pix_clk = mxGetScalar(prhs[1]);    
    if ((pix_clk < 5) || (pix_clk > 40))
        
    {
        mexErrMsgTxt("Pixel clock input values must be between 5 and 40"); 
        return;
    }
    double exp_int = mxGetScalar(prhs[2]);    
    if ((exp_int < 0) || (exp_int > 78))
    {
        mexErrMsgTxt("Exposure interval must be between 0 and 78"); 
        return;
    }
    
    double fps_int = mxGetScalar(prhs[3]);    
    if ((fps_int < 0) || (exp_int > 100))
    {
        mexErrMsgTxt("FPS interval must be between 0 and 100"); 
        return;
    }
        
    int error = 0;
    HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
    

    int pc=floor(pix_clk);
    error = is_SetPixelClock (cam, pc);
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error setting pixel clock"); 
    }
    //To print: 
    mexPrintf("Pixel clock set to: %d \n", pc);
    
    // Set frame rate to minimum allowable
    double fps_actual;
//     double min_frame_time, max_frame_time,  frame_time_interval, fps_actual;
//     error = is_GetFrameTimeRange (cam, &min_frame_time, &max_frame_time, &frame_time_interval);
//     if (error != IS_SUCCESS) 
//     {
//         mexErrMsgTxt("Error getting frame rate info"); 
//     }
//     double time_interval_int,new_frame_time;
//     time_interval_int=(1-fps_int/100)*(max_frame_time-min_frame_time)/frame_time_interval;
//     new_frame_time=floor(time_interval_int)*frame_time_interval+min_frame_time;            
    error = is_SetFrameRate (cam, fps_int, &fps_actual);
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error setting frame rate"); 
    }
     //To print: 
    mexPrintf("Frame rate set to (fps): %f \n", fps_actual);
    
    // Set exposure exposure time to input value
    double new_exposure_time, current;
//     double min, max, interval, current, new_exposure_time,new_exp_int;
//     error = is_GetExposureRange (cam, &min, &max, &interval);
//       mexPrintf("Exposure time min: %g \n", min);
//       mexPrintf("Exposure time max: %g \n", max);
//       mexPrintf("Exposure time interval: %g \n", interval);
    if (error != IS_SUCCESS) 
    {
        mexErrMsgTxt("Error accessing exposure range"); 
    }
    // new exposure time should be a multiple of interval, not implemented
//     new_exp_int=exp_int/78*(max-min)/interval;
//     new_exposure_time =  floor(new_exp_int)*interval+min ; 
    new_exposure_time=exp_int;
    error = is_SetExposureTime (cam, new_exposure_time, &current);
    if (error != IS_SUCCESS) 
   {
      mexErrMsgTxt("Error setting exposure time"); 
   }
    //To print: 
    mexPrintf("Exposure time set to (ms): %g \n", current);
    
    // Give time for settings to update on camera
    Sleep(500);  
    return;   
}
