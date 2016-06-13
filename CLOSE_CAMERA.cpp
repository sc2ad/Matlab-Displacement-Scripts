#include "C:\Program Files\MATLAB\R2013a\extern\include\mex.h"
#include "C:\Program Files\MATLAB\R2013a\extern\include\matrix.h"
#include "uc480.h"
#include "uc480_deprecated.h"

void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray*prhs[] )
{     
    /* Check for proper number of arguments */
    if (!(nrhs == 2) || !(nlhs==0)) 
    {   
        mexErrMsgTxt("You have to input camera handle"); 
    }  
    
    if (!mxIsStruct(prhs[1]))
    {
        mexErrMsgTxt("That second input has to be an image structure, you know.");
    }
    int error = 0;
    HCAM cam = *(HCAM *)mxGetPr(prhs[0]);
    
    int pointer_field = mxGetFieldNumber(prhs[1],"pointer");
    int ID_field = mxGetFieldNumber(prhs[1],"ID");
       
    mxArray *ppointer_field = mxGetFieldByNumber(prhs[1],0,pointer_field);
    char *p_image = (char *)*(int *)mxGetPr(ppointer_field);
    mxArray *pID_field = mxGetFieldByNumber(prhs[1],0,ID_field);
    int *ID = (int *)mxGetPr(pID_field); 

    if (cam!= NULL)
	{
		error = is_FreeImageMem( cam, p_image, *ID );
		if (error != IS_SUCCESS) 
		{
			mexErrMsgTxt("Error freeing image memory"); 
		}

		//Close and exit camera
		error = is_ExitCamera( cam );
		if (error != IS_SUCCESS) 
		{
		   mexErrMsgTxt("Error exiting camera"); 
		}
		cam = NULL;
		p_image = NULL;
        mexPrintf("Memory freed. \n");
	}
    
    return;   
}
