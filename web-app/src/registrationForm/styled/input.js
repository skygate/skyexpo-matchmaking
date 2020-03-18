import styled from '@emotion/styled';
import { css } from '@emotion/core';

import { color, fontSize } from '../../config/values';

const commonStyles = css`
    width: 100%;
    box-sizing: border-box;
    padding: 0.8rem 2rem;
    margin-top: 0.5rem;
    border-radius: 0.3rem;
    background-color: ${color.elementBackground};
    opacity: 0.75;
    border: none;
    font-size: ${fontSize.normal};
    outline-color: ${color.inputOutline};
`;

export const Input = styled.input`
    ${commonStyles}
`;

export const Textarea = styled.textarea`
    ${commonStyles}
    min-height:3rem;
    resize: vertical;
`;
