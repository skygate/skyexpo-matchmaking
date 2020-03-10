import * as Yup from 'yup';
import * as R from 'ramda';

import { emailValidityRegex } from './emailValidation';
import { phoneRegExp } from './phoneNumberValidation';
import { dateValidityRegex } from './dateValidation';

const startupValidationPage1 = Yup.object().shape({
    name: Yup.string()
        .trim()
        .required('Startup name  is required'),
    website: Yup.string()
        .url()
        .required('Website is required'),
    phoneNumber: Yup.string()
        .matches(phoneRegExp, 'Invalid phone number')
        .required('Phone number is required'),
    email: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
    country: Yup.string()
        .trim()
        .required('Country is required'),
    logotype: Yup.mixed().required('Logo is required'),
    foundingDate: Yup.string()
        .trim()
        .matches(dateValidityRegex, 'Date must be YYYY-MM-DD format')
        .required('Founding date is required'),
    description: Yup.string()
        .trim()
        .required('Short description is required'),
});

const companyValidationPage1 = Yup.object().shape({
    name: Yup.string()
        .trim()
        .required('Company name  is required'),
    website: Yup.string()
        .url()
        .required('Website is required'),
    phoneNumber: Yup.string()
        .matches(phoneRegExp, 'Invalid phone number')
        .required('Phone number is required'),
    email: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
    country: Yup.string()
        .trim()
        .required('Country is required'),
    logotype: Yup.string()
        .trim()
        .required('Logo is required'),
    foundingDate: Yup.string()
        .trim()
        .matches(dateValidityRegex, 'Date must be YYYY-MM-DD format')
        .required('Founding date is required'),
    description: Yup.string()
        .trim()
        .required('Short description is required'),
});

const individualValidationPage1 = Yup.object().shape({
    name: Yup.string()
        .trim()
        .required('Full name  is required'),
    website: Yup.string()
        .url()
        .required('Website is required'),
    phoneNumber: Yup.string()
        .matches(phoneRegExp, 'Invalid phone number')
        .required('Phone number is required'),
    email: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
    country: Yup.string()
        .trim()
        .required('Country is required'),
    logotype: Yup.string()
        .trim()
        .required('Logo is required'),
    foundingDate: Yup.string()
        .trim()
        .matches(dateValidityRegex, 'Date must be YYYY-MM-DD format')
        .required('Founding date is required'),
    description: Yup.string()
        .trim()
        .required('Short description is required'),
});

const validationPage2 = Yup.object().shape({
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

const validationPage3 = Yup.object().shape({
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
    investmentStage: Yup.array().of(
        Yup.string()
            .trim()
            .required('Sectors are required'),
    ),
    companyStage: Yup.string()
        .trim()
        .required('Company stage is required'),
    productTypes: Yup.array().of(
        Yup.string()
            .trim()
            .required('Product types are required'),
    ),
    isProductOnMarket: Yup.boolean().required('Please define if your product is on market'),
    targetMarket: Yup.array().of(
        Yup.string()
            .trim()
            .required('Target market is required'),
    ),
    businessType: Yup.array().of(
        Yup.string()
            .trim()
            .required('Business type is required'),
    ),
    minInvestmentSize: Yup.number().required('Minimum investment is required'),
    maxInvestmentSize: Yup.number().required('Maximum investment required'),
});

export const startupValidationSchemas = [startupValidationPage1, validationPage2, validationPage3];
export const companyInvestorValidationSchemas = [
    companyValidationPage1,
    validationPage2,
    validationPage3,
];
export const individualInvestorValidationSchemas = [individualValidationPage1, validationPage3];
