      SUBROUTINE TAB24A(SG60,DEGF,VCFC,VCFP,IFLAG)
      
      double precision SG60, DEGF, VCFC,VCFP
      integer IHYDRO, IFLAG

      DATA IBAS /600/
      DATA IBP1,IBP2 /7795,8250/
      DATA NBP1 /10760/
      
      DATA ITMP1,ITMP2,ITMP3 /2000,2500,3000/
      DATA IEP1,IEP2,IEP3/1500,2000,2500/
      DATA IESG/7585/
      DATA IFSG /6110/
      DATA IBT1/0/
      
      
      DATA K0,K1/3410957,0/

      VCFC=-1.0000
      VCFP=-1.0000
      IFLAG=-1
      
      ISG=(SG60*100000.0 + 25.0)/ 50.0
      ISG=ISG*5
      SG60=FLOAT(ISG)/10000.
      ITEMP=DEGF*10.0 + 0.5
      DEGF=FLOAT(ITEMP)/10.0
      
      IF(ISG-IFSG)10,20,20
 10   CONTINUE
      RETURN
 20   IF(ISG-NBP1)30,30,10
 30   CONTINUE
      
      IDT=ITEMP-IBAS
      IF(ITEMP-IBT1)40,50,50
 40   CONTINUE
      RETURN
 50   IF(ISG-IBP1)60,60,70
 60   IF(ITEMP-ITMP1)100,100,40
 70   IF(ISG-IBP2)80,80,90
 80   IF(ITEMP-ITMP2)100,100,40
 90   IF(ITEMP-ITMP3)100,100,40
 100  CONTINUE
      IX=ISG*1000
      IY=9990120
      
      CALL MPY24A(IX,IY,IDEN,10000)
      IDEN=(IDEN+5)/10
      
      
      CALL ALFA24A(IDEN, K0, K1, IALF)
      
      CALL VCF24A(IALF, IDT, IVCF)
      IFLAG=0
      
      IF(ISG-IESG)170,170,160
 160  CONTINUE
      IFLAG=1
      GO TO 220
 170  IF(ISG-IBP1)180,180,190
 180  IF(ITEMP-IEP1)220,220,160
 190  IF(ISG-IBP2)200,200,210
 200  IF(ITEMP-IEP2)220,220,160
 210  IF(ITEMP-IEP3)220,220,160
 220  CONTINUE
      
      JVCF=(IVCF/1000+5)/10
      PVCF=JVCF
      PVCF=PVCF/10000.
      IF(IVCF-100000000)230,240,240
 230  CONTINUE
      
      JVCF=(IVCF/100+5)/10
      CVCF=JVCF
      CVCF=CVCF/100000.
      GO TO 250
 240  CONTINUE
      CVCF=PVCF
 250  CONTINUE
      VCFP=PVCF
      VCFC=CVCF
      RETURN
      END
      

      







      
      
      SUBROUTINE DIV24A(INUM,IDENOM,IRES,ISCALE)
      
      
      IRES1=INUM/IDENOM
      IRES2=(INUM-IRES1*IDENOM)*ISCALE/IDENOM
      
      IRES=IRES1*ISCALE+IRES2
      RETURN
      END
      
      SUBROUTINE ALFA24A(IRHO,K0,K1,IALF)
      INUM=K1*10000
      CALL DIV24A(INUM,IRHO,IALF1,10000)
      
      INUM=K0*100
      CALL DIV24A(INUM,IRHO,IALFS,10000)
      CALL DIV24A(IALFS,IRHO,IALF2,10000)
      IALF=(IALF1+IALF2+500)/1000
      RETURN
      END
      
      SUBROUTINE VCF24A(IALF,IDT,IVCF)
      
      ITERM1=IALF*IDT
      ITERM2=ITERM1/5*4
      
      CALL MPY24A(ITERM1,ITERM2,ITERM3,10000)
      IX=-ITERM1-ITERM3
      
      ISUM1=100000000+IX
      CALL MPY24A(IX,IX,ISUM2,10000)
      ISUM2=ISUM2/2
      CALL MPY24A(IX,ISUM2,ISUM3,10000)
      ISUM3=ISUM3/3
      CALL MPY24A(IX,ISUM3,ISUM4,10000)
      ISUM4=ISUM4/4
      CALL MPY24A(IX,ISUM4,ISUM5,10000)
      ISUM5=ISUM5/5
      CALL MPY24A(IX,ISUM5,ISUM6,10000)
      ISUM6=ISUM6/6
      
      IVCF=ISUM1+ISUM2+ISUM3+ISUM4+ISUM5+ISUM6
      RETURN
      END
      
      
      SUBROUTINE MPY24A(IX,IY,IZ,ISCALE)
      
      
      IU1=IX/ISCALE
      K1=ISCALE*IU1
      IV1=IX-K1
      IU2=IY/ISCALE
      K2=ISCALE*IU2
      IV2=IY-K2
      K3=IU1*IV2+IU2*IV1+IV1*IV2/ISCALE
      IZ=(K3+ISCALE/2)/ISCALE + IU1*IU2
      RETURN
      END
      

      