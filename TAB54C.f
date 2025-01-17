      SUBROUTINE TAB54C(ALF15,DEGC,VCFC,VCFP,IFLAG)
      
      double precision ALF15, DEGC, VCFC, VCFP
      integer IHYDRO, IFLAG


      DATA IEP1,IEP2,IEP3/12000,9000,6000/
      DATA NBP1,NBP2/4860,16740/
      DATA IBP1,IBP2/9180,9540/
      DATA ITMP1,ITMP2,ITMP3/15000,12500,9500/
      DATA IBAS /1500/
      DATA IBT1/-1800/
      
      
      VCFC=-1.0000
      VCFP=-1.0000
      IFLAG=-1
      
      ITEMP=DEGC*1000.
      IF(ITEMP.GT.0)ITEMP=ITEMP+25
      IF(ITEMP.LT.0)ITEMP=ITEMP-25
      ITEMP=ITEMP/50*5
      
      DEGC=FLOAT(ITEMP)/100.
      IALF=(ALF15*10000000.0+5.0)/10.0
      IALF=IALF*10
      ALF15=FLOAT(IALF)/10000000.
      
      
      IF(IALF-NBP1)10,20,20
 10   CONTINUE
      RETURN
 20   IF(IALF-NBP2)30,30,10
 30   CONTINUE
      
      IF(ITEMP-IBT1)40,50,50
      
 40   CONTINUE
      RETURN
 50   IF(IALF-IBP1)60,60,70
 60   IF(ITEMP-ITMP1)100,100,40
 70   IF(IALF-IBP2)80,80,90
 80   IF(ITEMP-ITMP2)100,100,40
 90   IF(ITEMP-ITMP3)100,100,40
 100  CONTINUE
      
      IIALF=IALF
      IDT=ITEMP-IBAS
      
      CALL VCF54C(IALF, IDT, IVCF)
      IFLAG=0
      
      IF(IALF-IBP1)101,101,110
 101  IF(ITEMP-IEP1)140,140,105
 105  IFLAG=1
      GO TO 140
 110  IF(IALF-IBP2)120,120,130
 120  IF(ITEMP-IEP2)140,140,105
 130  IF(ITEMP-IEP3)140,140,105 
 140  CONTINUE
      
      JVCF=(IVCF/1000+5)/10
      PVCF=JVCF
      PVCF=PVCF/10000.
      IF(IVCF-100000000)150,160,160
 150  CONTINUE
      
      JVCF=(IVCF/100+5)/10
      CVCF=JVCF
      CVCF=CVCF/100000.
      GO TO 180
 160  CONTINUE
      CVCF=PVCF
 180  CONTINUE
      VCFP=PVCF
      VCFC=CVCF
      RETURN
      END
      

      







      
      
      SUBROUTINE DIV54C(INUM,IDENOM,IRES,ISCALE)
      
      
      IRES1=INUM/IDENOM
      IRES2=(INUM-IRES1*IDENOM)*ISCALE/IDENOM
      
      IRES=IRES1*ISCALE+IRES2
      RETURN
      END
      
      
      SUBROUTINE VCF54C(IALF,IDT,IVCF)
      
      ITERM1=IALF*IDT
      ITERM1=ITERM1/10
      ITERM2=ITERM1/5*4
      
      CALL MPY54C(ITERM1,ITERM2,ITERM3,10000)
      IX=-ITERM1-ITERM3
      
      ISUM1=100000000+IX
      CALL MPY54C(IX,IX,ISUM2,10000)
      ISUM2=ISUM2/2
      CALL MPY54C(IX,ISUM2,ISUM3,10000)
      ISUM3=ISUM3/3
      CALL MPY54C(IX,ISUM3,ISUM4,10000)
      ISUM4=ISUM4/4
      CALL MPY54C(IX,ISUM4,ISUM5,10000)
      ISUM5=ISUM5/5
      CALL MPY54C(IX,ISUM5,ISUM6,10000)
      ISUM6=ISUM6/6
      
      IVCF=ISUM1+ISUM2+ISUM3+ISUM4+ISUM5+ISUM6
      RETURN
      END
      
      
      SUBROUTINE MPY54C(IX,IY,IZ,ISCALE)
      
      
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
      

      
