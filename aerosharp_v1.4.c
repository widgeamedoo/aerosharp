    #include <stdio.h>   /* Standard input/output definitions */
    #include <string.h>  /* String function definitions */
    #include <unistd.h>  /* UNIX standard function definitions */
    #include <fcntl.h>   /* File control definitions */
    #include <errno.h>   /* Error number definitions */
    #include <termios.h> /* POSIX terminal control definitions */
    #include <time.h>
//-------- These settings can easily be changed if required --------
     char *serial_port = "/dev/aerosharp"; 
     char *path_to_rrd = "/usr/bin/rrdtool";
     float version = 1.4;
//------------------------------------------------------------------
     int debug =1;
     int fd;
     char send_buffer[]={0xAA,0x05,0x02,0x00,0x00,0x00,0x02,0x00,0x00};
     struct termios newtio;
     int inverter_data[34];
     char inverter_hex_data[34];
     char *array [4] = {"Grid Frequency", "two", "three", "four"};
     char the_time[50];
     char the_date[50]; 
//------- Function prototypes----------------------------------------
     void initialise(int, char *[]);
     float count_chars( char list,int count); 
     float combine_left_all(unsigned int left_byte, unsigned int right_byte);
     float combine_right_all(unsigned int left_byte, unsigned int right_byte);
     int read_bogus_port();
     void get_time();
     void get_date();
     void display_sent_buffer();
     int open_port();
     void display_sent_buffer();
     int close_port();
     int write_port();
     int read_port();

//--------------------------------------------------------------------
   int main(int argc, char *argv[])
{
   while (1) {  
     initialise(argc,argv);
     fd = open_port();
     int rc = set_port();
     rc = write_port();
     display_sent_buffer();
     usleep(300000);
     rc = read_port();
     //read_bogus_port();   //uncommented this out
     rc = close_port();
     //usleep(9350000);
    // usleep(17700000);   // was 18700000
  }
}
//-------------------------------------------------------------------- 
   void initialise(int argc, char *argv[]) {
     int i;
      for(i = 1; i < argc; i++)
      {
       int count = i;
       if (strcmp(argv[i],"-p") == 0) {
           serial_port = argv[i+1];
           //printf("\n %s and %s",argv[i],serial_port);
          }
       if (strcmp(argv[i],"-d") == 0) {
           debug = 1;
          }
       if (strcmp(argv[i],"-r") == 0) {
           path_to_rrd = argv[i+1];
           //printf("\n %s and %s",argv[i],path_to_rrd);
          }
  
      }
}
//--------------------------------------------------------------------
   int set_port() {
    memset(&newtio, 0, sizeof(newtio));
    newtio.c_cflag &= ~CRTSCTS;                 /* disable hardware flow control */
    newtio.c_cflag &= ~PARENB;                  /* no parity */
    newtio.c_cflag &= ~CSTOPB;                  /* on stop bit */
    newtio.c_cflag &= ~CSIZE;                   /* character size mask */
    newtio.c_cflag &= ~HUPCL;                   /* no hangup */
    newtio.c_cflag |= CS8 | CLOCAL | CREAD;
    newtio.c_iflag |= IXON | IXOFF;
    newtio.c_iflag |= IGNBRK | IGNPAR;          /* ignore BREAK condition on input & framing errors & parity errors */
    newtio.c_oflag = 0;                         /* set serial device input mode (non-canonical, no echo,...) */
    newtio.c_oflag &= ~OPOST;                   /* enable output processing */
    newtio.c_lflag = 0;
    newtio.c_cc[VTIME]    = 1;                  /* timeout in 1/10 sec intervals */
    newtio.c_cc[VMIN]     = 0;
    cfsetospeed (&newtio, B9600);
    cfsetispeed (&newtio, B9600);
    tcsetattr(fd, TCSANOW, &newtio);
    return 0;
}
//--------------------------------------------------------------------
    int open_port(int argc, char *argv[])
    {
      fd = open(serial_port, O_RDWR | O_NOCTTY | O_NDELAY );
      if (fd == -1)
      {
	printf("open_port: Unable to open %s",serial_port);
      }
      else {
        if (debug)
             printf("\nSuccessfully opened port %s",serial_port);
      }
	fcntl(fd, F_SETFL, FNDELAY);

      return (fd);
    }
//--------------------------------------------------------------------
void display_sent_buffer() {
   int i;
   get_time(); 
   get_date();
   if (debug) {
       printf("\nSent this command: ");
       for (i = 0; i < sizeof(send_buffer); i++) {
                printf("%02X",(unsigned char)send_buffer[i]);
           }
      }
   printf("\n-| V%0.1f |--------| Reading Inverter at %s %s |---------",version, the_date,the_time);
}
//--------------------------------------------------------------------
int close_port()
 {
   close(fd);
   if (debug)
             printf("\nClosing port %s",serial_port);
   return 0;
 }
//--------------------------------------------------------------------
int write_port() {
   tcflush(fd,TCIOFLUSH);
   int n = write(fd, send_buffer, sizeof(send_buffer));
   if (n < 0)
      fputs("write() of bytes failed!\n", stderr);
   else {
      if (debug) 
          printf("\nWrote %i bytes in the request to inverter.", n);
    }
   tcdrain(fd);
   return 0;
}
//--------------------------------------------------------------------
// This function is helpful when the inverter has shut down for the night
// it will return data as if the inverter was still running.. the same
// data will be returned every poll but its better than nothing :)
int read_bogus_port() {
  char bogus_buffer[]={0x5,0x8,0x2,0x1c,0xf4,0x96,0x19,0x2e,0xd8,0x09,0xd8,0x09,0x0,0x0,0x0,0x0,0xa4,0x2b,0x2b,0x88,0x00,0x66,0x0,0x8b,0x1,0x0,0x0,0xa2,0xbc,0x3,0x0,0x0,0x68};
  int nbytes = 1;
  int count=1;
  unsigned char *c;
  c=&bogus_buffer[0];
  while(count < 34) {
    //printf("\n%02x ",*c);  
    count_chars(*c,count);
    count++;
    c++;
  }
  return 0;
}
//--------------------------------------------------------------------
int read_port() {
  char buf;
  char finalbuff[34];
  char *buff_ptr;
  int nbytes = 1;
  char message[90];
  buff_ptr=finalbuff;
  int count=1;
  while(nbytes > 0) {
        nbytes=read(fd, &buf, sizeof(char));
        if (nbytes > 0)
           {
       //    printf("%i: %02x  --- %li ",count,buf,buf);
             count_chars(buf,count);
             long int i = buf; 
       //    printf("%i: %d \n",count,i);
             count++;
           }
    }
}
//--------------------------------------------------------------------
float count_chars(char list,int count) {
  unsigned char *c;
  float rc;
  c = &list;
  inverter_data[count] = c[0];
  char cmd[100];
  //printf("%i: %02x ",count,inverter_data[count]);
  if (count == 5) {   // Grid Frequency Minor
        // wait till count=7 to process this      
     }

  if (count == 6) {   // Grid Voltage Minor
        // wait till count = 7 to process this
     } 

  if (count == 7) {   // 1st byte = Grid Frequency 25.6 - 6528 / 2nd byte = Grid Voltage 25.6 - 6528
        rc = combine_left_all(inverter_data[7],inverter_data[5]);
        printf("\nGrid Frequency     = %8.1f",rc);
        sprintf(cmd, "%s update aerosharp_grid_frequency.rrd --template grid_frequency N:%0.1f",path_to_rrd,rc);
        system(cmd);
        if (debug)
           printf("\n%s",cmd);
        rc = combine_right_all(inverter_data[7],inverter_data[6]);
        printf("\nGrid Voltage       = %8.1f",rc);       
        sprintf(cmd, "%s update aerosharp_grid_voltage.rrd --template grid_voltage N:%0.1f",path_to_rrd,rc);
        system(cmd);
        if (debug)
           printf("\n%s",cmd);
     }

  if (count == 8) {   // AC Amps 0 - 25.5 
        //int ac_amps = inverter_data[8];
        
        float d1 = inverter_data[8];
        printf("\nAC Amps / Current  = %8.1f",d1/10.0);
        sprintf(cmd, "%s update aerosharp_ac_amps.rrd --template ac_amps N:%0.1f",path_to_rrd,d1/10.0);
        system(cmd); 
        if (debug)
           printf("\n%s",cmd);
     }

  if (count == 11) {   // PV1 Volts 0 - 25.5
        // wait till count = 12 to process this
     }

  if (count == 12 ) {   // PV1 Volts 25.6 - 6528
        rc = inverter_data[12] << 8 | inverter_data[11];
        printf("\nPV1 Volts          = %8.1f",rc/10.0);
        sprintf(cmd, "%s update aerosharp_pv1_volts.rrd --template pv1_volts N:%0.1f",path_to_rrd,rc/10.0);
        system(cmd);
        if (debug)
           printf("\n%s",cmd);
     }

  if (count == 13) {   // PV1 Current 0 - 25.5
        float d1 = inverter_data[13];
        printf("\nPV1 current        = %8.1f ",d1/10.0); 
        sprintf(cmd, "%s update aerosharp_pv1_current.rrd --template pv1_current N:%0.1f",path_to_rrd,d1/10);
        system(cmd);
        if (debug)
           printf("\n%s",cmd);
     }

  if (count == 14) {   // PV2 Volts 0 - 25.5
        // wait till count = 15 to process this
     }

  if (count == 15 ) {   // PV2 Volts 25.6 - 6528
        rc = inverter_data[15] << 8 | inverter_data[14];
        printf("\nPV2 Volts          = %8.1f",rc/10.0);
        sprintf(cmd, "%s update aerosharp_pv2_volts.rrd --template pv2_volts N:%0.1f",path_to_rrd,rc/10);
        system(cmd);
        if (debug)
           printf("\n%s",cmd);
     }

  if (count == 16) {   // PV2 Current 0 - 25.5
        float d1 = inverter_data[16];
        printf("\nPV2 current        = %8.1f",d1/10.0);
        sprintf(cmd, "%s update aerosharp_pv2_current.rrd --template pv2_current N:%0.1f",path_to_rrd,d1/10);
        system(cmd);
        if (debug)
           printf("\n%s",cmd);
     }

  if (count == 17) {   // AC Power Watts 0 - 25.5
        // wait till count = 18 to process this
     }

  if (count == 18 ) {   // AC Power Watts 25.6 - 6528
        rc = inverter_data[18] << 8 | inverter_data[17];
        printf("\nAC Power (Watts)   = %8.1f",rc/10.0);
        sprintf(cmd, "%s update aerosharp_ac_watts.rrd --template ac_watts N:%0.1f",path_to_rrd,rc/10);
        system(cmd); 
        if (debug)
           printf("\n%s",cmd);
     }

  if (count == 19) {   // Temperature 0 - 255
        float d1 = inverter_data[19];
        printf("\nInternal Temp (C)  = %8.1f",d1);
        int t = d1;
        sprintf(cmd, "%s update aerosharp_temp.rrd --template temp N:%i",path_to_rrd,t);
        system(cmd);
        if (debug)
           printf("\n%s",cmd);
     }
 
  if (count == 22) {   // Energy today 0 - 25.5
        // wait till count = 23 to process this
     }

  if (count == 23 ) {   // Energy today 25.6 - 6528
        rc = inverter_data[23] << 8 | inverter_data[22];
        printf("\nEnergy today (kWh) = %8.1f",rc/10.0);
        sprintf(cmd, "%s update aerosharp_energy_today.rrd --template energy_today N:%0.1f",path_to_rrd,rc/10);
        system(cmd); 
        if (debug)
           printf("\n%s",cmd);
     }
     
  if (count == 26 ) {   // Energy total 65536 - 16711680
        rc = inverter_data[26] << 16 | inverter_data[25] << 8 | inverter_data[24];
        printf("\nEnergy total (kWh) = %8.1f",rc);
     }  
 
  if (count == 28) {   // Time Today 0 - 25.5
        float d1 = inverter_data[28];
        printf("\nTime Today (Hrs)   = %8.1f",d1/10);
     } 

  if (count == 31 ) {   // Time Total 65536 - 16711680
        rc = inverter_data[31] << 16 | inverter_data[30] << 8 | inverter_data[29];
        printf("\nTime total (Hrs)   = %8.1f",rc);
     }
 
return rc;
}
//--------------------------------------------------------------------
void get_time() {
  struct tm *OurT = NULL;
  time_t Tval = 0;
  Tval = time(NULL);
  OurT = localtime(&Tval);  
  sprintf(the_time,"%02d:%02d:%02d", OurT->tm_hour,  OurT->tm_min, OurT->tm_sec);
  
}

//--------------------------------------------------------------------
void get_date() {
  int i = 3;                                
  struct tm *OurT = NULL;                   
  time_t Tval = 0;
  Tval = time(NULL);
  OurT = localtime(&Tval);

  switch( OurT->tm_mday )
  {
    case 1: case 21: case 31:
      i= 0;                  /* Select "st" */
      break;
    case 2: case 22:
      i = 1;                 /* Select "nd" */
      break;
    case 3: case 23:
      i = 2;                 /* Select "rd" */
      break;
    default:
      i = 3;                 /* Select "th" */
      break;
  }

    sprintf(the_date,"%02d-%02d-%d", OurT->tm_mday,  OurT->tm_mon+1, 1900 + OurT->tm_year);
}
//--------------------------------------------------------------------
float combine_left_all(unsigned int left_byte, unsigned int right_byte) { // lets get the left part of left_byte and ALL of right_byte and join em
  float combined = 0;
  unsigned int left;
  unsigned int right;
  //printf("\n Got %i %i\n",left_byte,right_byte); 
  //printf("\nLeft %x",left_byte >>4);
  //printf("\nRight %x\n",right_byte);
   combined = left_byte << 4 | right_byte;
   float d1;
   d1 = combined/10;
   //printf("\nCombined %f\n",d1);
  return d1;
}
//--------------------------------------------------------------------
float combine_right_all(unsigned int left_byte, unsigned int right_byte) { // lets get the right part of left_byte and ALL of right_byte and join em
  float combined = 0;
  unsigned int left;
  unsigned int right;
 // printf("\nGot %i %i\n",left_byte,right_byte);
 // printf("\nLeft %x",left_byte & 0xF);
 // printf("\nRight %x\n",right_byte );
   combined = (left_byte & 0xF) << 8  | right_byte;
   float d1;
   d1 = combined/10;
 //  printf("\nCombined %f\n",d1);
  return d1;
}
//--------------------------------------------------------------------

