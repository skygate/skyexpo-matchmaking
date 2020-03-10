import styled from '@emotion/styled';
import { color, fontSize } from '../../config/values';
import { SpaceBetweenWrapper } from './space-between-wrapper';

export const ButtonsWrapper = styled(SpaceBetweenWrapper)`
    margin-top: 2rem;
`;

export const Button = styled.button`
    border-radius: 1.5rem;
    margin: 10rem auto;
    border: none;
    padding: 0.5rem 2.5rem;
    font-size: ${fontSize.normal};
    margin: 0;
`;

export const BackButton = styled(Button)`
    background-color: ${color.primaryBackground};
`;

export const NextButton = styled(Button)`
    background-color: ${color.elementBackground};
`;
