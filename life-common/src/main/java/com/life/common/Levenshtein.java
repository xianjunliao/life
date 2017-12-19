package com.life.common;

/**
 * Created by xiao on 2017/5/10.
 */
public class Levenshtein {
        private int compare(String str, String target) {
            int d[][]; // 矩阵
            int n = str.length();
            int m = target.length();
            int i; // 遍历str的
            int j; // 遍历target的
            char ch1; // str的
            char ch2; // target的
            int temp; // 记录相同字符,在某个矩阵位置值的增量,不是0就是1

            if (n == 0) {
                return m;
            }

            if (m == 0) {
                return n;
            }

            d = new int[n + 1][m + 1];

            for (i = 0; i <= n; i++) { // 初始化第一列
                d[i][0] = i;
            }

            for (j = 0; j <= m; j++) { // 初始化第一行
                d[0][j] = j;
            }

            for (i = 1; i <= n; i++) { // 遍历str
                ch1 = str.charAt(i - 1);
                // 去匹配target
                for (j = 1; j <= m; j++) {
                    ch2 = target.charAt(j - 1);
                    if (ch1 == ch2) {
                        temp = 0;
                    } else {
                        temp = 1;
                    }

                    // 左边+1,上边+1, 左上角+temp取最小
                    d[i][j] = min(d[i - 1][j] + 1, d[i][j - 1] + 1, d[i - 1][j - 1] + temp);
                }
            }

            return d[n][m];
        }

        private int min(int one, int two, int three) {
            return (one = one < two ? one : two) < three ? one : three;
        }

        /**
         * 获取两字符串的相似度
         *
         * @param str
         * @param target
         *
         * @return
         */

        public float getSimilarityRatio(String str, String target) {
            return 1 - (float) compare(str, target) / Math.max(str.length(), target.length());

        }

        public static void main(String[] args) {
        	//Levenshtein lt = new Levenshtein();
            //String str = "【海利生物：两股东计划清仓减持 合计占比5.09%】财联社11日讯，海利生物股东Navigation Five Limited计划六个月内通过减持不超过1587.9万股的公司股份，即不超过公司总股本的2.4656%；百灏投资有限公司计划六个月内减持不超过1688.6万股的公司股份，即不超过公司总股本的2.6220%。";
            //String target = "【海利生物：两股东拟半年内清仓减持】海利生物(603718)5月11日晚公告，公司持股2.4656%的股东Navigation及持股2.622%的股东百灏投资计划6个月内，分别减持不超1588万股（即不超公司总股本2.4656%）、1689万股（即不超公司总股本2.622%）。（证券时报）";
            //System.out.println("similarityRatio=" + lt.getSimilarityRatio(str, target));
        }

}
