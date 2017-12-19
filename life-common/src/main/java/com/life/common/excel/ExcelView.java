package com.life.common.excel;

import io.swagger.annotations.ApiModel;

@ApiModel("银行 信息过滤，Created by XHZ on 2017/9/29")
public interface ExcelView {
    interface Public {}

    interface Admin extends Public {}

    interface All extends Admin{}
}