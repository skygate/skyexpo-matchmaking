import * as R from 'ramda';

import * as helpers from './';
import { questionsMock } from '../mocks/questions';
describe('Helpers', () => {
    it('Should count progress from given questions', () => {
        const progressPercent = helpers.countProgress(questionsMock);
        expect(progressPercent).toBe(50);
    });
    it('Should prepare values for only one step, omit tags property because it is in other step then provided in test', () => {
        const stepValues = helpers.getStepValues(
            helpers.startupFormSteps[0].inputsFields,
            questionsMock,
        );

        expect(stepValues).toMatchObject(R.omit(['tags'], questionsMock));
    });
});
