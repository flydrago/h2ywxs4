/**
 * Author:Mr.Lu
 * Function:精确数学计算
 * DateTime:2015年5月19日 10:35:25
 */

/**
 * 数据精确计算小数位
 */
function getDotNum(num){
	
	var temp = num + "";
	var length = temp.length;
	var _length = temp.split(".")[0].length;
	
	if(length == _length){
		return 0;
	}else{
		return length - _length - 1;
	}
}


/**
 * 获取两个数中小数位最大的小数位数
 */
function getMaxDotNum(num1,num2){
	
	return Math.max(getDotNum(num1), getDotNum(num2));
}

/**
 * 精确计算两数之和
 */
function accurateSum(num1,num2){
	
	var _maxDotNum = getMaxDotNum(num1,num2);
	return  ( num1 * Math.pow(10,_maxDotNum) + num2 * Math.pow(10,_maxDotNum) ) / Math.pow(10,_maxDotNum);
}

/**
 * 精确计算两数之积
 */
function accurateMultiply(num1,num2){
	
	var _maxDotNum = getMaxDotNum(num1,num2);
	return  (num1 * Math.pow(10,_maxDotNum)) * (num2 * Math.pow(10,_maxDotNum)) / Math.pow(10,_maxDotNum * 2);
}


/**
 * 精确计算两数之差 绝对值
 */
function accurateMinus(num1,num2){
	
	var _maxDotNum = getMaxDotNum(num1,num2);
	return  Math.abs( num1 * Math.pow(10,_maxDotNum) - num2 * Math.pow(10,_maxDotNum) ) / Math.pow(10,_maxDotNum);
}
