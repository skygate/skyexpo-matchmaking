import React from 'react';
import styled from '@emotion/styled';

import { color, fontSize } from '../../config/values';
import downloadIcon from '../../assets/download-icon.svg';

export const UploadWrapper = styled.label`
    width: 100%;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 0.8rem 2rem;
    margin-top: 0.5rem;
    border-radius: 0.3rem;
    background-color: ${color.elementBackground};
    opacity: 0.75;
    border: none;
    font-size: ${fontSize.normal};
    cursor: pointer;
`;

export const UploadInput = styled.input`
    display: none;
`;

export const SubTitle = styled.span`
    margin-top: 0.5em;
    font-size: ${fontSize.small};
`;

export const UploadIcon = styled.img`
    width: 6rem;
    margin: 1rem 0;
`;

export const UploadButton = props => (
    <>
        <UploadWrapper htmlFor="file-upload">
            <UploadIcon src={downloadIcon}></UploadIcon>
            <span>Select a image</span>
            <SubTitle>PNG, JPG, or GIF file under 1 MB in size</SubTitle>
        </UploadWrapper>
        <UploadInput id="file-upload" type="file" onChange={props.onChange} />
    </>
);
