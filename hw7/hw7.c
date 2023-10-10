#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define N 99999 // 精度微小數點後五位

int main (){

struct timespec tt1, tt2;
/*
//自行產生隨機變數-->data.txt
  FILE *fp = fopen("data.txt","w");  

  srand(time(NULL));

  double j;
  
  for(int i=0;i<400;i++){
  
    for(int k=0;k<198;k++){
  
  	j = rand() % (N+1) / (double) (N+1);
  
  	fprintf(fp,"%.5lf ",j);
    }
    fprintf(fp,"\n");
  }
  
  fclose(fp);
 */
//讀檔並分別存成2個矩陣  
clock_gettime(CLOCK_REALTIME, &tt1); 
  freopen("data.txt","r",stdin);
  
  double matrix_A[200][198],matrix_B[200][198];
  
  for(int i=0;i<200;i++){
  	for(int j=0;j<198;j++){
  		scanf("%lf",&matrix_A[i][j]);
  	}
  }

  for(int i=0;i<200;i++){
  	for(int j=0;j<198;j++){
  		scanf("%lf",&matrix_B[i][j]);
  	}
  }
clock_gettime(CLOCK_REALTIME, &tt2); 
printf("讀取資料花了 %ld nanoseconds\n",tt2.tv_nsec - tt1.tv_nsec);
//初始化
  double ans[200];
  
  for(int i=0;i<200;i++){  
  	
  	ans[i]=0;
  
  }
  
//計算
clock_gettime(CLOCK_REALTIME, &tt1); 
   for(int i=0;i<200;i++){
   	for(int j=0;j<200;j++){
   		for(int k=0;k<198;k++){
   			ans[i]=ans[i]+matrix_A[i][k]*matrix_B[j][k];  //一個一個相加
   		}
   	}
   
   }
clock_gettime(CLOCK_REALTIME, &tt2);
printf("運算花了 %ld nanoseconds\n",tt2.tv_nsec - tt1.tv_nsec);

//輸出到-->output.txt
clock_gettime(CLOCK_REALTIME, &tt1); 
   FILE *fp2 = fopen("output.txt","w");
   for(int i=0;i<200;i++){ 
   	fprintf(fp2,"%.5lf\n",ans[i]);	 
   }
   fclose(fp2);
clock_gettime(CLOCK_REALTIME, &tt2);
printf("寫出資料花了 %ld nanoseconds\n",tt2.tv_nsec - tt1.tv_nsec);
  return 0;
}
