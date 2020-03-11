import styled from '@emotion/styled';
import { color, fontSize } from '../../config/values';

export const Input = styled.input`
    width: 100%;
    padding: 0.8rem 2rem;
    margin-top: 0.5rem;
    border-radius: 0.3rem;
    background-color: ${color.elementBackground};
    opacity: 0.75;
    border: none;
    font-size: ${fontSize.normal};
`;
