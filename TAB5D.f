     
      SUBROUTINE TAB5D(API,DEGF, IHYDRO, API60, IFLAG)
      
      DOUBLE PRECISION API, DEGF, API60
      INTEGER IHYDRO, IFLAG

      DATA IBASE /600/
      DATA LIM1,LIM2/1164000,800000/
      DATA NBP1 / 450 /
      DATA ITMP1 / 3000 /
      DATA K0, K1 / 0, 34878 /
      DATA KONST / 1413601980 /
      NOUT = 6
      IR=5
      IF(API) 5, 10, 10
 5    IR=-5
 10   IAPI=( (API*100)+IR)/10
      API=FLOAT(IAPI)/10.0
      IF (DEGF) 900, 20, 20
 20   IT=((DEGF*100)+5)/10
      DEGF=FLOAT(IT)/10.0
      IF (IAPI+100) 900, 40, 40
 40   IF(IAPI-NBP1) 50, 50, 900
 50   IF(IT-ITMP1) 100, 100, 900
 100  CONTINUE
      IFLAG=0
      IDT=IT-IBASE
      CALL RHO5D(IAPI,IRHOT)
      IF(IHYDRO) 101, 101, 140
 101  IRD=50
      IF(IDT)105, 110, 110
 105  IRD=-50
 110  IH1=(127800*IDT+IRD)/100
      IH2=(62*IDT*IDT+500)/1000
      IHYC=1000000000-IH1-IH2
      IRHO=IRHOT*10
      CALL MPY5D(IRHO, IHYC, IRHOT,10000)
      IRHOT=(IRHOT+50)/100
 140  JRHOT=IRHOT*10000
      IRHO60=IRHOT
      KRHO=0
      NP=0
 300  NP=NP+1
      CALL ALF5D(IRHO60,K0,K1,IALF)
      CALL VCF5D(IALF,IDT,IVCF)
      IVCF=(IVCF+50)/100
      CALL DIV5D(JRHOT,IVCF,IRHO60,1000)
      IF(IABS(IRHO60-KRHO)-50)500, 320, 320
 320  KRHO=IRHO60
      IRHO60=(IRHO60+5)/10
      IF(NP-20) 300, 400, 400
 400  IFLAG=-1
      API60=-99.9
      WRITE(NOUT,6001)DEGF, API
 6001 FORMAT(5H1 AT ,F5.1,15H DEGREES F AND ,F5.1,    66H DEGREES API, A
     & CORRESPONDING API AT 60F COULD NOT BE DETERMINED. )

      
 500  IF (IRHO60-LIM1)510,510,900
 510  IF(IRHO60-LIM2)900,520,520
 520  IRHO60=((IRHO60 + 5) / 10)
      IAPI60=KONST/IRHO60 - 13150
      
      IR=5
      IF(IAPI60)530, 540, 540
 530  IR=-5
 540  IAPI60=(IAPI60+IR)/10
      API60=IAPI60 * .1
      
 820  CONTINUE
      RETURN
      
 900  IFLAG=-1
      API60=-99.9
      RETURN
      END
      
      


      SUBROUTINE RHO5D(IAPI,IRHO)
      
      IDENOM=IAPI+1315
      IRHO=(1413601980/IDENOM+5)/10
      RETURN
      END
      
      SUBROUTINE DIV5D(INUM,IDENOM,IRES,ISCALE)
      
      
      IRES1=INUM/IDENOM
      IRES2=(INUM-IRES1*IDENOM)*ISCALE/IDENOM
      
      IRES=IRES1*ISCALE+IRES2
      RETURN
      END
      
      SUBROUTINE ALF5D(IRHO,K0,K1,IALF)
      INUM=K1*1000
      CALL DIV5D(INUM,IRHO,IALF1,10000)
      
      INUM=K0*100
      CALL DIV5D(INUM,IRHO,IALFS,10000)
      CALL DIV5D(IALFS,IRHO,IALF2,10000)
      IALF=(IALF1+IALF2+500)/1000
      RETURN
      END
      
      SUBROUTINE VCF5D(IALF,IDT,IVCF)
      
      ITERM1=IALF*IDT
      ITERM2=ITERM1/5*40
      
      CALL MPY5D(ITERM1,ITERM2,ITERM3,1000)
      ITERM3=(ITERM3+500)/1000
      IX=-ITERM1-ITERM3
      
      ISUM1=100000000+IX
      CALL MPY5D(IX,IX,ISUM2,1000)
      ISUM2=((ISUM2+50)/100)/2
      CALL MPY5D(IX,ISUM2,ISUM3,1000)
      ISUM3=((ISUM3+50)/100)/3
      CALL MPY5D(IX,ISUM3,ISUM4,1000)
      ISUM4=((ISUM4+50)/100)/4
      CALL MPY5D(IX,ISUM4,ISUM5,1000)
      ISUM5=((ISUM5+50)/100)/5
      CALL MPY5D(IX,ISUM5,ISUM6,1000)
      ISUM6=((ISUM6+50)/100)/6
      
      IVCF=ISUM1+ISUM2+ISUM3+ISUM4+ISUM5+ISUM6
      RETURN
      END
      
      
      SUBROUTINE MPY5D(IX,IY,IZ,ISCALE)
      
      
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
      

      