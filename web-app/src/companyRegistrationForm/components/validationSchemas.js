import * as Yup from 'yup';

import { emailValidityRegex } from '../../helpers/emailValidation';

export const validationPage1 = Yup.object().shape({
    firstName: Yup.string()
        .trim()
        .required('First Name is required'),
    lastName: Yup.string()
        .trim()
        .required('Last Name is required'),
    email: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
});

export const validationPage2 = Yup.object().shape({
    firstName1: Yup.string()
        .trim()
        .required('First Name is required'),
    lastName1: Yup.string()
        .trim()
        .required('Last Name is required'),
    email1: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
});

export const validationPage3 = Yup.object().shape({
    firstName2: Yup.string()
        .trim()
        .required('First Name is required'),
    lastName2: Yup.string()
        .trim()
        .required('Last Name is required'),
    email2: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
});
