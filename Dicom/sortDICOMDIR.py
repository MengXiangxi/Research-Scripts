from os.path import dirname, join
import shutil
from pydicom.filereader import read_dicomdir

path = './DICOMDIR'
series_no = 2
destination = './sorted'

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

            if series.SeriesNumber == series_no:
                image_records = series.children
                image_filenames = [join(base_dir, *image_rec.ReferencedFileID)
                                for image_rec in image_records]
                for dcmfile in image_filenames:
                    print(dcmfile)
                    shutil.copy(dcmfile, destination)