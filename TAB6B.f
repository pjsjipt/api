      SUBROUTINE TAB6B(API60,DEGF,VCFC,VCFP,IFLAG)
      
      double precision API60, DEGF, VCFC,VCFP
      integer IHYDRO, IFLAG

      DATA NBP1,NBP2,NBP3,NBP4 /370,480,520,850/
      DATA IBP1,IBP2 /400,500/
      DATA ITMP1,ITMP2,ITMP3 /3000,2500,2000/
      DATA IBAS /600/
      DATA IEP1,IEP2,IEP3/2500,2000,1500/
      DATA IEAPI/550/
      
      DATA K0F, K1F /1038720, 2701/
      DATA K0J, K1J /3303010, 0/
      DATA K0T, K1T /14890670,-186840/
      DATA K0G, K1G /1924571, 2438/
      
      

      VCFC=-1.0000
      VCFP=-1.0000
      IFLAG=-1
      
      IAPI=api60*10.0 + 0.5
      API60=FLOAT(IAPI) / 10.0
      ITEMP=DEGF*10.0 + 0.5
      DEGF=FLOAT(ITEMP)/10.0
      IDT=ITEMP-IBAS
      IFLAG=-1
      
      IF(IAPI)10,20,20
 10   CONTINUE
      RETURN
 20   IF(IAPI-NBP1)30,30,40
 30   K0=K0F
      K1=K1F
      GO TO 80
 40   IF(IAPI-NBP2)50,60,60
 50   K0=K0J
      K1=K1J
      GO TO 80
 60   IF (IAPI-NBP3)70,70,75
 70   K0=K0T
      K1=K1T
      GO TO 80
 75   IF(IAPI-NBP4)78,78,10
 78   K0=K0G
      K1=K1G
 80   CONTINUE
      
      
      
      IF(ITEMP)90,100,100
 90   CONTINUE
      RETURN
 100  IF(IAPI-IBP1)110,110,120
 110  IF(ITEMP-ITMP1)150,150,90
 120  IF(IAPI-IBP2)130,130,140
 130  IF(ITEMP-ITMP2)150,150,90
 140  IF(ITEMP-ITMP3)150,150,90
 150  CONTINUE
      
      CALL RHO6B(IAPI,IRHO)
      
      IF(K0.NE.K0T)GO TO 155
      CALL DIV6B(K0,IRHO,IRES,10000)
      IRES=IRES*10
      CALL DIV6B(IRES,IRHO,IALF1,10000)
      IALF1=(IALF1+5)/10
      IALF=(IALF1+K1+5)/10
      GO TO 158
 155  CALL ALFA6B(IRHO, K0, K1, IALF)
 158  CONTINUE
      
      
      CALL VCF6B(IALF, IDT, IVCF)
      IFLAG=0
      
      IF(IAPI-IBP1)160,160,170
 160  IF (ITEMP-IEP1)200,200,165
 165  IFLAG=1
      GO TO 200
 170  IF(IAPI-IBP2)180,180,190
 180  IF(ITEMP-IEP2)200,200,165
 190  IF(ITEMP-IEP3)200,200,165
 200  CONTINUE
      
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
      

      







      
      SUBROUTINE RHO6B(IAPI,IRHO)
      
      IDENOM=IAPI+1315
      IRHO=(1413601980/IDENOM+5)/10
      RETURN
      END
      
      SUBROUTINE DIV6B(INUM,IDENOM,IRES,ISCALE)
      
      
      IRES1=INUM/IDENOM
      IRES2=(INUM-IRES1*IDENOM)*ISCALE/IDENOM
      
      IRES=IRES1*ISCALE+IRES2
      RETURN
      END
      
      SUBROUTINE ALFA6B(IRHO,K0,K1,IALF)
      INUM=K1*10000
      CALL DIV6B(INUM,IRHO,IALF1,10000)
      
      INUM=K0*100
      CALL DIV6B(INUM,IRHO,IALFS,10000)
      CALL DIV6B(IALFS,IRHO,IALF2,10000)
      IALF=(IALF1+IALF2+500)/1000
      RETURN
      END
      
      SUBROUTINE VCF6B(IALF,IDT,IVCF)
      
      ITERM1=IALF*IDT
      ITERM2=ITERM1/5*4
      
      CALL MPY6B(ITERM1,ITERM2,ITERM3)
      IX=-ITERM1-ITERM3
      
      ISUM1=100000000+IX
      CALL MPY6B(IX,IX,ISUM2)
      ISUM2=ISUM2/2
      CALL MPY6B(IX,ISUM2,ISUM3)
      ISUM3=ISUM3/3
      CALL MPY6B(IX,ISUM3,ISUM4)
      ISUM4=ISUM4/4
      CALL MPY6B(IX,ISUM4,ISUM5)
      ISUM5=ISUM5/5
      CALL MPY6B(IX,ISUM5,ISUM6)
      ISUM6=ISUM6/6
      
      IVCF=ISUM1+ISUM2+ISUM3+ISUM4+ISUM5+ISUM6
      RETURN
      END
      
      
      SUBROUTINE MPY6B(IX,IY,IZ)
      
      ISCALE=10000
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
      

      
