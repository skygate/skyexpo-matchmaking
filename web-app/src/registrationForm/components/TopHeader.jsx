import React from 'react';
import { CircularProgressbar } from 'react-circular-progressbar';
import styled from '@emotion/styled';

import { SpaceBetweenWrapper } from '../styled/space-between-wrapper';

export const ProgressBarWrapper = styled.div`
    width: 5rem;
`;
export const SubTitle = styled.p`
    margin: 0;
`;

export const TopHeader = props => (
    <SpaceBetweenWrapper>
        <div>
            <SubTitle>Registration step {props.step + 1}</SubTitle>
            <h1>{props.title}</h1>
        </div>
        <ProgressBarWrapper>
            <CircularProgressbar
                value={props.completionProgress}
                text={`${props.completionProgress}%`}
            />
        </ProgressBarWrapper>
    </SpaceBetweenWrapper>
);
