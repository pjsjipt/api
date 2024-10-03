c     PROGRAMA TAB5B
      
      
      SUBROUTINE TAB5B(API, DEGF, IHYDRO, API60, IFLAG)
      
      double precision API, DEGF, API60
      INTEGER IFLAG, IHYDRO
      
      DATA IBASE /600/
      DATA NBP1 /850/
      DATA IBP1, IBP2 /400,500/
      DATA ITMP1, ITMP2, ITMP3 /3000,2500,2000/
      DATA IEP1, IEP2, IEP3 /2500, 2000, 1500/
      
      DATA K0F, K1F /1038720, 2701/
      DATA NHIF /370/
      DATA K0J, K1J /3303010, 0/
      DATA NLOJ, NHIJ /371, 500/
      
      DATA K0G, K1G /1924571, 2438/
      DATA NLOG/501/
      
      DATA LIM1, LIM2/1074982,652934/
      DATA INT1, INT2 /480, 520/
      DATA IA, IB /-186840,14890670/
      
      DATA KONST /1413601980/
      
      NOUT = 6
      IAPI=((API*100)+5)/10
      API=FLOAT(IAPI)/10.0
      
      IF (DEGF) 1200, 20, 20
 20   IT = ( (DEGF*100)+5)/10
      DEGF=FLOAT(IT)/10.0
      
      IF(IAPI)1200, 40, 40
 40   IF(IAPI-NBP1) 50,50,1200
 50   IF(IAPI-IBP1)60,60,70
 60   IF(IT-ITMP1)100, 100, 1200
 70   IF(IAPI-IBP2)80,80,90
 80   IF(IT-ITMP2)100, 100, 1200
 90   IF(IT-ITMP3)100,100,1200
 100  CONTINUE
      
      IFLAG=0
      
      IDT=IT-IBASE
      CALL RHO5B(IAPI,IRHOT)
      
      IF (IHYDRO)101,101,111
      
 101  IRD=50
      IF(IDT)105,110,110
 105  IRD=-50
 110  IH1=(127800*IDT+IRD)/100
      IH2=(62*IDT*IDT+500)/1000
      IHYC=1000000000 - IH1 - IH2
      
      IRHO=IRHOT*10
      CALL MPY5B(IRHO,IHYC,IRHOT,10000)
      
      IRHOT=(IRHOT+50)/100
 111  JRHOT=IRHOT*10000
 112  ICOUNT=0
      IF (IAPI-NHIF)115,115,120
 115  K0=K0F
      K1=K1F
      IREG=0
      GO TO 150
 120  IF(IAPI-NHIJ)125,125,130
 125  K0=K0J
      K1=K1J
      IREG=1
      GO TO 150
 130  K0=K0G
      K1=K1G
      IREG=2
      
 150  ICOUNT=ICOUNT+1
      
      IF(ICOUNT-2)160,160,400
      
 160  IRHO60=IRHOT
      KRHO=0
      NP=0
 300  NP=NP+1
      
      CALL ALF5B(IRHO60, K0, K1, IALF)
      CALL VCF5B(IALF, IDT, IVCF)
      IVCF=(IVCF+50)/100
      
      CALL DIV5B(JRHOT,IVCF,IRHO60,1000)
      
      IF(IABS(IRHO60-KRHO)-50)500,320,320
      
 320  KRHO=IRHO60
      
      IRHO60=(IRHO60+5)/10
      
      IF(NP-20)300,1150,1150
      
 400  KRHO=0
      NP=0
      ICOUNT=3
      
      IRHO60=77884
      
 440  NP=NP+1
      
      CALL DIV5B(IB,IRHO60,IRES,10000)
      IRES=IRES*10
      CALL DIV5B(IRES,IRHO60,IRES2,10000)
      IRES2=(IRES2+5)/10
      IALF=(IA+IRES2+5)/10
      CALL VCF5B(IALF,IDT,IVCF)
      IVCF=(IVCF+50)/100
      CALL DIV5B(JRHOT,IVCF,IRHO60,1000)
      
      IF(IABS(IRHO60-KRHO)-70)500,460,460
      
 460  KSAV=KRHO
      KRHO=IRHO60
      IRHO60=(IRHO60+5)/10
      IF(NP-40)440,480,480
      
      
 480  IRHO60=(KRHO+KSAV)/2
      
 500  IF(IRHO60 - LIM1)510, 510, 1200
 510  IF(IRHO60-LIM2)1200,520,520
 520  IRHO60 = ((IRHO60 + 5)/10)
      IAPI60=KONST/IRHO60 - 13150
      IAPI60=(IAPI60+5)/10
      API60=FLOAT(IAPI60)/10.
      
      IF (ICOUNT - 3)600, 720, 720
 600  IF(IREG-1)610,620,640
 610  IF(IAPI60-NHIF)680,680,125
 620  IF(IAPI60-NHIJ)630,680,130
 630  IF(IAPI60-NLOJ)115,680,680
 640  IF(IAPI60-NLOG)125,680,680
      
 680  CONTINUE
      
      IF(IAPI60-INT1)720,400,690
 690  IF(IAPI60-INT2)400,400,720
      
 720  IF(IAPI-IBP1)780,780,790
 780  IF(IT-IEP1)820,820,830
 790  IF(IAPI-IBP2)800,800,810
 800  IF(IT-IEP2)820,820,830
      
 810  IF(IT-IEP3)820,820,830
 820  CONTINUE
      RETURN
      
 830  IFLAG=1
      RETURN
 1150 WRITE(NOUT,6020)DEGF,API
 6020 FORMAT(5H1 AT ,F5.1,15H DEGREES F AND ,F5.1,   66H DEGREES API, A
     1 CORRESPONDING API AT 60F COULD NOT BE DETERMINED.)
      
 1200 IFLAG=-1
      API60=-99.9
      RETURN
      
      END
      
      SUBROUTINE RHO5B(IAPI,IRHO)
      
      IDENOM=IAPI+1315
      IRHO=(1413601980/IDENOM+5)/10
      RETURN
      END
      

      SUBROUTINE DIV5B(INUM,IDENOM,IRES,ISCALE)
      
      
      IRES1=INUM/IDENOM
      IRES2=(INUM-IRES1*IDENOM)*ISCALE/IDENOM
      
      IRES=IRES1*ISCALE+IRES2
      RETURN
      END
      
      SUBROUTINE ALF5B(IRHO,K0,K1,IALF)
      INUM=K1*10000
      CALL DIV5B(INUM,IRHO,IALF1,10000)
      
      INUM=K0*100
      CALL DIV5B(INUM,IRHO,IALFS,10000)
      CALL DIV5B(IALFS,IRHO,IALF2,10000)
      IALF=(IALF1+IALF2+500)/1000
      RETURN
      END
      
      SUBROUTINE VCF5B(IALF,IDT,IVCF)
      
      ITERM1=IALF*IDT
      ITERM2=ITERM1/5*40
      
      CALL MPY5B(ITERM1,ITERM2,ITERM3,1000)
      ITERM3=(ITERM3+500)/1000
      IX=-ITERM1-ITERM3
      
      ISUM1=100000000+IX
      CALL MPY5B(IX,IX,ISUM2,1000)
      ISUM2=((ISUM2+50)/100)/2
      CALL MPY5B(IX,ISUM2,ISUM3,1000)
      ISUM3=((ISUM3+50)/100)/3
      CALL MPY5B(IX,ISUM3,ISUM4,1000)
      ISUM4=((ISUM4+50)/100)/4
      CALL MPY5B(IX,ISUM4,ISUM5,1000)
      ISUM5=((ISUM5+50)/100)/5
      CALL MPY5B(IX,ISUM5,ISUM6,1000)
      ISUM6=((ISUM6+50)/100)/6
      
      IVCF=ISUM1+ISUM2+ISUM3+ISUM4+ISUM5+ISUM6
      RETURN
      END
      
      
      SUBROUTINE MPY5B(IX,IY,IZ,ISCALE)
      
      
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
      
      
      
