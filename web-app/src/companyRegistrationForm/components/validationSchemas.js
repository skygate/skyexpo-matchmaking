import * as Yup from 'yup';
import * as R from 'ramda';

import { emailValidityRegex } from '../../helpers/emailValidation';
import { phoneRegExp } from '../../helpers/phoneNumberValidation';

export const validationPage1 = Yup.object().shape({
    companyName: Yup.string()
        .trim()
        .required('Company name  is required'),
    website: Yup.string()
        .trim()
        .required('Website is required'),
    phone: Yup.string()
        .matches(phoneRegExp, 'Invalid phone number')
        .required('Phone is required'),
    companyContact: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
    country: Yup.string()
        .trim()
        .required('Country is required'),
    foundingDate: Yup.string()
        .trim()
        .required('Founding date is required'),
    shortDescription: Yup.string()
        .trim()
        .required('Short description is required'),
});

export const validationPage2 = Yup.object().shape({
    logo: Yup.string()
        .trim()
        .required('Logo is required'),
    teamMembers: Yup.array().of(
        Yup.lazy(obj =>
            Yup.object().shape(
                R.mapObjIndexed((value, key) => {
                    if (key.includes('name')) {
                        return Yup.string().required('Team member name is required');
                    }
                    if (key.includes('email')) {
                        return Yup.string()
                            .matches(emailValidityRegex, 'Invalid email address')
                            .required('Team member email is required');
                    }
                }, obj),
            ),
        ),
    ),
});

export const validationPage3 = Yup.object().shape({
    industries: Yup.array().of(
        Yup.string()
            .trim()
            .required('Industries are required'),
    ),
    sectors: Yup.array().of(
        Yup.string()
            .trim()
            .required('Sectors are required'),
    ),
    companyStage: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
    productType: Yup.array().of(
        Yup.string()
            .trim()
            .required('Product types are required'),
    ),
});
