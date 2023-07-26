from os.path import dirname, join
from pprint import pprint
import pydicom
from pydicom.filereader import read_dicomdir

path = './DICOMDIR'

#load the data 
dicom_dir = read_dicomdir(path)
base_dir = dirname(path)

#go through the patient record and print information
for patient_record in dicom_dir.patient_records:
    if (hasattr(patient_record, 'PatientID') and
            hasattr(patient_record, 'PatientName')):
        print("Patient: {}: {}".format(patient_record.PatientID,
                                       patient_record.PatientName))
    studies = patient_record.children
    # got through each serie
    for study in studies:
        print(" " * 4 + "Study {}: {}: {}".format(study.StudyID,
                                                  study.StudyDate,
                                                  study.StudyDescription))
        all_series = study.children
        # go through each serie
        for series in all_series:
            image_count = len(series.children)
            plural = ('', 's')[image_count > 1]

            # Write basic series info and image count

            # Put N/A in if no Series Description
            if 'SeriesDescription' not in series:
                series.SeriesDescription = "N/A"
            print(" " * 8 + "Series {}: {}: {} ({} image{})".format(
                series.SeriesNumber, series.Modality, series.SeriesDescription,
                image_count, plural))