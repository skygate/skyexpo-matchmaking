import * as Yup from 'yup';

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
        Yup.object().shape({
            name: Yup.string().required('Team member name is required'),
            email: Yup.string()
                .matches(emailValidityRegex, 'Invalid email address')
                .required('Team member email is required'),
        }),
    ),
});

export const validationPage3 = Yup.object().shape({
    industries: Yup.string()
        .trim()
        .required('First Name is required'),
    sectors: Yup.string()
        .trim()
        .required('Last Name is required'),
    companyStage: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
    productType: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
});
