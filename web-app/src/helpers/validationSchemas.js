import * as Yup from 'yup';
import * as R from 'ramda';

import { emailValidityRegex } from './emailValidation';
import { phoneRegExp } from './phoneNumberValidation';
import { dateValidityRegex } from './dateValidation';

export const validationPage1 = Yup.object().shape({
    startupName: Yup.string()
        .trim()
        .required('Startup name  is required'),
    website: Yup.string()
        .url()
        .required('Website is required'),
    phone: Yup.string().matches(phoneRegExp, 'Invalid phone number'),
    startupContact: Yup.string()
        .trim()
        .matches(emailValidityRegex, 'Invalid email address')
        .required('Email is required'),
    country: Yup.string()
        .trim()
        .required('Country is required'),
    logo: Yup.string()
        .trim()
        .required('Logo is required'),
    foundingDate: Yup.string()
        .trim()
        .matches(dateValidityRegex, 'Date must be YYYY-MM-DD format')
        .required('Founding date is required'),
    shortDescription: Yup.string()
        .trim()
        .required('Short description is required'),
});

export const validationPage2 = Yup.object().shape({
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
    investmentStage: Yup.array().of(
        Yup.string()
            .trim()
            .required('Sectors are required'),
    ),
    companyStage: Yup.string()
        .trim()
        .required('Company stage is required'),
    productType: Yup.array().of(
        Yup.string()
            .trim()
            .required('Product types are required'),
    ),
    productOnMarket: Yup.boolean().required('Please define if your product is on marekt'),
    minimumInvest: Yup.number().required('Minimum investment is required'),
    maximumInvest: Yup.number().required('Maximum investment required'),
});
