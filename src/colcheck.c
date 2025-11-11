typedef struct{
  int cur;  
  int step; 
} colinfo_t;

// |       | Byte |   Byte | Packed |
// | Field | Size | Offset |   Bits |
// |-------+------+--------+--------|
// | cur   |    4 |     +0 |   0-31 |
// | step  |    4 |     +4 |  32-64 |

int col_check(colinfo_t info){
  int cur = info.cur;
  int step = info.step;
  int errs = 0;

  if(cur <= 0){
    errs = errs | 0x1; // 0b0001
  }
  if(step < 0){
    errs = errs | 0x2; // 0b0010
  }
  if(cur==1 && step < 0){
    errs = errs | 0x4; // 0b0100
  }
  
  return errs;
}
