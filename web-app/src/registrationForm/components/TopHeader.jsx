import React from 'react';
import { Progress } from 'antd';

export const TopHeader = props => (
    <>
        <h1>Registration step {props.step + 1}</h1>
        <Progress type="circle" percent={props.completionProgress} width={80} />
    </>
);
