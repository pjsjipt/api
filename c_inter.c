// Interface c para criar uma interface EXCEL para as subrotinas de cálculo de coreção
// de temperatura API cap 11.1


// Declaração das funções em fortran
void tab6a_(double *, double *, double *, double *, int *);
void tab6b_(double *, double *, double *, double *, int *);
void tab6c_(double *, double *, double *, double *, int *);
void tab6d_(double *, double *, double *, double *, int *);

void tab24a_(double *, double *, double *, double *, int *);
void tab24b_(double *, double *, double *, double *, int *);
void tab24c_(double *, double *, double *, double *, int *);
void tab24d_(double *, double *, double *, double *, int *);

void tab54a_(double *, double *, double *, double *, int *);
void tab54b_(double *, double *, double *, double *, int *);
void tab54b_(double *, double *, double *, double *, int *);
void tab54d_(double *, double *, double *, double *, int *);


void tab5a_(double *, double *, int *, double *, int *);
void tab5b_(double *, double *, int *, double *, int *);
void tab5d_(double *, double *, int *, double *, int *);

void tab23a_(double *, double *, int *, double *, int *);
void tab23b_(double *, double *, int *, double *, int *);
void tab23d_(double *, double *, int *, double *, int *);

void tab53a_(double *, double *, int *, double *, int *);
void tab53b_(double *, double *, int *, double *, int *);
void tab53d_(double *, double *, int *, double *, int *);




/******************************************************************************
 *               TABELA 11.1 6   (A,B,C,D)                                    *
 ******************************************************************************/

__declspec(dllexport) double __stdcall api6a(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab6a_(api60, degf, vcfc, vcfp, iflag);
}

__declspec(dllexport) double __stdcall api6b(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab6b_(api60, degf, vcfc, vcfp, iflag);
}
__declspec(dllexport) double __stdcall api6c(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab6c_(api60, degf, vcfc, vcfp, iflag);
}
__declspec(dllexport) double __stdcall api6d(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab6d_(api60, degf, vcfc, vcfp, iflag);
}




/******************************************************************************
 *               TABELA 11.1 24  (A,B,C,D)                                    *
 ******************************************************************************/

__declspec(dllexport) double __stdcall api24a(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab24a_(api60, degf, vcfc, vcfp, iflag);
}
   
__declspec(dllexport) double __stdcall api24b(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab24b_(api60, degf, vcfc, vcfp, iflag);
}


__declspec(dllexport) double __stdcall api24c(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab24c_(api60, degf, vcfc, vcfp, iflag);
}

__declspec(dllexport) double __stdcall api24d(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab24d_(api60, degf, vcfc, vcfp, iflag);
}

  
/******************************************************************************
 *               TABELA 11.1 54  (A,B,C,D)                                    *
 ******************************************************************************/

__declspec(dllexport) double __stdcall api54a(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab54a_(api60, degf, vcfc, vcfp, iflag);
}
   
__declspec(dllexport) double __stdcall api54b(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab54b_(api60, degf, vcfc, vcfp, iflag);
}


__declspec(dllexport) double __stdcall api54c(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab54c_(api60, degf, vcfc, vcfp, iflag);
}

__declspec(dllexport) double __stdcall api54d(double *api60, double *degf, double *vcfc,
					     double *vcfp, int *iflag)
{
  tab54d_(api60, degf, vcfc, vcfp, iflag);
}

  






/******************************************************************************
 *               TABELA 11.1 5   (A,B,C,D)                                    *
 ******************************************************************************/

__declspec(dllexport) double __stdcall api5a(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab5a_(api, degf, ihydro, api60, iflag);
}


__declspec(dllexport) double __stdcall api5b(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab5b_(api, degf, ihydro, api60, iflag);
}
__declspec(dllexport) double __stdcall api5d(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab5d_(api, degf, ihydro, api60, iflag);
}







/******************************************************************************
 *               TABELA 11.1 23  (A,B,C,D)                                    *
 ******************************************************************************/

__declspec(dllexport) double __stdcall api23a(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab23a_(api, degf, ihydro, api60, iflag);
}


__declspec(dllexport) double __stdcall api23b(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab23b_(api, degf, ihydro, api60, iflag);
}
__declspec(dllexport) double __stdcall api23d(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab23d_(api, degf, ihydro, api60, iflag);
}



/******************************************************************************
 *               TABELA 11.1 53  (A,B,C,D)                                    *
 ******************************************************************************/

__declspec(dllexport) double __stdcall api53a(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab53a_(api, degf, ihydro, api60, iflag);
}


__declspec(dllexport) double __stdcall api53b(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab53b_(api, degf, ihydro, api60, iflag);
}
__declspec(dllexport) double __stdcall api53d(double *api, double *degf, int *ihydro,
					     double *api60, int *iflag)
{
  tab53d_(api, degf, ihydro, api60, iflag);
}
