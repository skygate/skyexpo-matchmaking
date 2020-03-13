import styled from '@emotion/styled';

import { fontSize, color } from '../../config/values';
import { SpaceBetweenWrapper } from './';

export const RemoveButton = styled.button`
    font-size: ${fontSize.normal};
    background: ${color.primaryBackground};
    color: ${color.primaryFont};
    border: none;
    height: 1.5rem;
`;

export const AddButton = styled.button`
    margin-left: 1rem;
    background: transparent;
    border: none;
    padding: 0;
`;

export const AddIcon = styled.img`
    width: 1rem;
`;

export const AddText = styled.label`
    font-size: ${fontSize.normal};
    color: ${color.primaryFont};
`;

export const AddMemberWrapper = styled.div`
    display: flex;
    align-items: center;
    margin-top: 2rem;
`;

export const MemberHeader = styled.h2`
    margin: 0;
`;

export const MemberTopBar = styled(SpaceBetweenWrapper)`
    align-items: center;
    margin-top: 1rem;
`;
