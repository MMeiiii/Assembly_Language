#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <xmmintrin.h>
#define N 99999 // 精度微小數點後五位
int main (){
   
   struct timespec tt1, tt2;
   float A[200][200]__attribute__ ((aligned(16)));	
   float B[200][200]__attribute__ ((aligned(16)));
   float C[200]__attribute__ ((aligned(16)));;
   float D[200][200]__attribute__ ((aligned(16)));
   __m128 *a,*b,*c,*d;
   
/*//自行產生隨機變數-->data.txt
  FILE *fp = fopen("data.txt","w");  

  srand(time(NULL));

  double j;
  
  for(int i=0;i<400;i++){
  
    for(int k=0;k<400;k++){
  
  	j = rand() % (N+1) / (double) (N+1);
  
  	fprintf(fp,"%.5lf ",j);
    }
    fprintf(fp,"\n");
  }
  
  fclose(fp);   */
   
   
//讀入檔案並分別存入AB
clock_gettime(CLOCK_REALTIME, &tt1);    
  freopen("data.txt","r",stdin);
 
  for(int i=0;i<200;i++){
  	for(int j=0;j<200;j++){
  		if(j!=198 && j!=199){
  		   scanf("%f",&A[i][j]);  
  		}
  		else{
  		   A[i][j]=0; //要記得後面是為了對齊所以我都把它設成0
  		}
  	}
  }

  for(int i=0;i<200;i++){
  	for(int j=0;j<200;j++){
  		if(j!=198 && j!=199){
  		
  		  scanf("%f",&B[i][j]);  
  		
  		}
  		else{
  		
  		  B[i][j]=0; //要記得後面是為了對齊所以我都把它設成0
  		
  		}
  	}
  }
  
  for(int i=0;i<200;i++){  	
  	C[i]=0;
  }
clock_gettime(CLOCK_REALTIME, &tt2); 
printf("讀取資料花了 %ld nanoseconds\n",tt2.tv_nsec - tt1.tv_nsec);

 c = (__m128*) C;
//先把B裡每一行加起來
clock_gettime(CLOCK_REALTIME, &tt1);
   for(int i=0;i<50;i++){ //4個4個一組記得除4

        for(int j=0;j<200;j++){
   		b = (__m128*) B[j];
   		c = (__m128*) C;
   		c=c+i;  
   		b=b+i; 
   		*c = _mm_add_ps(*b,*c);
        }
   }
   
//把剛剛算好的B所有(其實就是C)乘上A

	for(int i=0;i<50;i++){ //4個4個一組記得除4
	
	   for(int j=0;j<200;j++){
	   	 a = (__m128*) A[j];
   		 c = (__m128*) C;
   		 d = (__m128*) D[j];
   		 c=c+i; //因為有移位記的加
   		 a=a+i;
   		 d=d+i; 
   		 *d = _mm_mul_ps(*a,*c);
	   }	
	}

 //把每一列的D相加
	float ans[200];	
	for(int i=0;i<200;i++){
 	   ans[i]=0;
 	   for(int j=0;j<198;j++){
 	   	ans[i]=ans[i]+D[i][j];	
 	   }	
 	}
clock_gettime(CLOCK_REALTIME, &tt2);
printf("運算花了 %ld nanoseconds\n",tt2.tv_nsec - tt1.tv_nsec);

//把答案放上output_SIMD.txt
 clock_gettime(CLOCK_REALTIME, &tt1); 
   FILE *fp2 = fopen("output_SIMD.txt","w");
 	for(int i=0;i<200;i++){
 	   fprintf(fp2,"%.5lf\n",ans[i]);	
 	}
 	
   fclose(fp2);
clock_gettime(CLOCK_REALTIME, &tt2);
printf("寫出資料花了 %ld nanoseconds\n",tt2.tv_nsec - tt1.tv_nsec);    
   return 0;
}
