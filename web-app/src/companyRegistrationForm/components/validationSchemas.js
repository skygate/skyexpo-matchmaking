import * as Yup from 'yup';

import { emailValidityRegex } from '../../helpers/emailValidation';

const phoneRegExp = /(([+][(]?[0-9]{1,3}[)]?)|([(]?[0-9]{4}[)]?))\s*[)]?[-\s\.]?[(]?[0-9]{1,3}[)]?([-\s\.]?[0-9]{3})([-\s\.]?[0-9]{3,4})/;

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
