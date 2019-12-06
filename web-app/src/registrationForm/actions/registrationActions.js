export const VALIDATE_FIRST_STEP_REQUESTED = 'VALIDATE_FIRST_STEP_REQUESTED';
export const validateFirstStepRequest = (formStep, type, step) => ({
    type: VALIDATE_FIRST_STEP_REQUESTED,
    payload: { formStep, type, step },
});

export const VALIDATE_FIRST_STEP_SUCCEEDED = 'VALIDATE_FIRST_STEP_SUCCEEDED';
export const validateFirstStepSuccess = () => ({
    type: VALIDATE_FIRST_STEP_SUCCEEDED,
});

export const VALIDATE_FIRST_STEP_FAILED = 'VALIDATE_FIRST_STEP_FAILED';
export const validateFirstStepFail = () => ({
    type: VALIDATE_FIRST_STEP_FAILED,
});

export const VALIDATE_TEAM_MEMBERS_REQUESTED = 'VALIDATE_TEAM_MEMBERS_REQUESTED';
export const validateTeamMembersRequest = (formStep, type, step) => ({
    type: VALIDATE_FIRST_STEP_REQUESTED,
    payload: { formStep, type, step },
});

export const VALIDATE_TEAM_MEMBERS_SUCCEEDED = 'VALIDATE_TEAM_MEMBERS_SUCCEEDED';
export const validateTeamMembersSuccess = () => ({
    type: VALIDATE_TEAM_MEMBERS_SUCCEEDED,
});

export const VALIDATE_TEAM_MEMBERS_FAILED = 'VALIDATE_TEAM_MEMBERS_FAILED';
export const validateTeamMembersFail = () => ({
    type: VALIDATE_TEAM_MEMBERS_FAILED,
});
