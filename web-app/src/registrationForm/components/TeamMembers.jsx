import React from 'react';
import { FieldArray } from 'formik';

import {
    Input,
    MemberTopBar,
    MemberHeader,
    RemoveButton,
    AddMemberWrapper,
    AddText,
    AddButton,
    AddIcon,
} from '../styled';
import addIcon from '../../assets/add-icon.svg';

export const TeamMembers = ({ values, errors, touched, handleChange }) => (
    <FieldArray
        name="teamMembers"
        render={arrayOfMembers => (
            <div>
                {values.teamMembers.map((_, index) => (
                    <div key={`name${index}`}>
                        <MemberTopBar>
                            <MemberHeader>
                                {index > 0 ? `Member ${index + 1}` : 'Your details'}
                            </MemberHeader>
                            {index > 0 && (
                                <RemoveButton
                                    type="button"
                                    onClick={() => arrayOfMembers.remove(index)}
                                >
                                    remove
                                </RemoveButton>
                            )}
                        </MemberTopBar>

                        <Input
                            onChange={handleChange}
                            name={`teamMembers.${index}.name`}
                            type="text"
                            placeholder="name"
                        />
                        {touched?.teamMembers?.[index]?.name && (
                            <span>{errors?.teamMembers?.[index]?.name}</span>
                        )}
                        <Input
                            onChange={handleChange}
                            name={`teamMembers.${index}.email`}
                            type="text"
                            placeholder="email"
                        />
                        {touched?.teamMembers?.[index]?.email && (
                            <span>{errors.teamMembers?.[index]?.email}</span>
                        )}
                    </div>
                ))}
                <AddMemberWrapper>
                    <AddText>Add new member</AddText>
                    <AddButton
                        type="button"
                        onClick={() =>
                            arrayOfMembers.push({
                                name: '',
                                email: '',
                            })
                        }
                    >
                        <AddIcon src={addIcon}></AddIcon>
                    </AddButton>
                </AddMemberWrapper>
            </div>
        )}
    />
);
