import React from 'react';
import Progress from 'antd/lib/progress';
import styled from '@emotion/styled';

import { SpaceBetweenWrapper } from '../styled/space-between-wrapper';

export const SubTitle = styled.p`
    margin: 0;
`;

export const TopHeader = props => (
    <SpaceBetweenWrapper>
        <div>
            <SubTitle>Registration step {props.step + 1}</SubTitle>
            <h1>{props.title}</h1>
        </div>

        <Progress type="circle" percent={props.completionProgress} width={80} />
    </SpaceBetweenWrapper>
);
