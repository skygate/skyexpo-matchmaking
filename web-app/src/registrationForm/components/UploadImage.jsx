import React, { useState } from 'react';

import downloadIcon from '../../assets/download-icon.svg';
import { UploadWrapper, UploadInput, UploadIcon, SubTitle, PreviewImage } from '../styled';
import { readFile } from '../../helpers';

export const UploadImage = ({ value, ...props }) => {
    const [imgPreviewUrl, setImgPreviewUrl] = useState('');

    const setPreviewOnChange = async event => {
        const file = event.target.files[0];
        const url = await readFile(file);

        setImgPreviewUrl(url);
    };

    return (
        <>
            <UploadWrapper htmlFor="file-upload">
                {value ? (
                    <>
                        <PreviewImage src={imgPreviewUrl}></PreviewImage>
                        <SubTitle>{value.name}</SubTitle>
                    </>
                ) : (
                    <>
                        <UploadIcon src={downloadIcon}></UploadIcon>
                        <span>Select a image</span>
                    </>
                )}
            </UploadWrapper>
            <UploadInput
                id="file-upload"
                type="file"
                onChange={event => {
                    if (event.target.value) {
                        props.onChange(event);
                        setPreviewOnChange(event);
                    }
                }}
                onBlur={props.handleBlur}
            />
        </>
    );
};
