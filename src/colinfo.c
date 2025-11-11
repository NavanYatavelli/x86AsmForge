typedef struct{
  int cur;     
  int step;    
} colinfo_t;

// |       | Byte |   Byte | Packed |
// | Field | Size | Offset |   Bits |
// |-------+------+--------+--------|
// | cur   |    4 |     +0 |   0-31 |
// | step  |    4 |     +4 |  32-64 |


int col_update(colinfo_t *info){

// Updates current value and step in
// colinfo_t pointed by param info. If
// infor->cur is invalid, makes no changes
// and returns 1 to indicate an
// error. Otherwise performs odd or even
// update on cur and increments step
// returning 0 for success.

int cur = info->cur;
int step = info->step;

if(cur <= 0){
	return 1;
}

step++;

if(cur % 2 == 1){
	cur = cur*3+1;
}
else {
	cur = cur / 2;
}

info->cur = cur;
info->step = step;

return 0;
}



