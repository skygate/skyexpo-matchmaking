import styled from '@emotion/styled';
import { color, fontSize } from '../../config/values';

export const ButtonsWrapper = styled.div`
    display: flex;
    justify-content: space-between;
`;

export const Button = styled.button`
    border-radius: 1.5rem;
    margin: 10rem auto;
    border: none;
    padding: 0.5rem 2rem;
    font-size: ${fontSize.normal};
    margin: 0;
`;

export const BackButton = styled(Button)`
    background-color: ${color.primaryBackground};
`;

export const NextButton = styled(Button)`
    background-color: ${color.elementBackground};
`;
