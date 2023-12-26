clear

source = "E:\DOTATATE\Batch3";
target = "D:\Sandbox\DOTATATE";

datedir = dir(source);
datedir(ismember({datedir.name},{'.','..'})) = [];

for ii = 1:length(datedir)
    studydir = dir(fullfile(source, datedir(ii).name));
    studydir(ismember({studydir.name},{'.','..'})) = [];
    for jj = 1:length(studydir)
        studypath = fullfile(source, datedir(ii).name, studydir(jj).name);
        seriesdir = dir(studypath);
        seriesdir(ismember({seriesdir.name},{'.','..'})) = [];
        PatientIDs = split(studydir(jj).name, "_");
        if ~startsWith(PatientIDs(2), "GA-TOC")
            warning("Wrong prefix in %s", studydir(jj).name)
        end
        AnonyPatientIDs = split(PatientIDs(2),'-TOC');
        AnonyPatientID = AnonyPatientIDs(2);
        outputpath = fullfile(target, AnonyPatientID);
        if ~exist(outputpath, 'dir'), mkdir(outputpath); end
        if sum(startsWith({seriesdir.name}, {'[WB_CTAC]'}))>0
            fprintf('The scanner for "%s" is Philips \n', studydir(jj).name)
            % Determine PET directory
            PET_series_dir = seriesdir;
            PET_series_dir(~(startsWith({PET_series_dir.name}, {'[WB_CTAC]'}))) = [];
            if length(PET_series_dir) == 1
                PET_series = PET_series_dir.name;
            else
                error('Unable to determine Philips PET in %s', studypath)
            end
            PET_sourcename = fullfile(seriesdir(1).folder, PET_series);
            PET_targetname = fullfile(outputpath, PET_series);
            dcm2nii_output(PET_sourcename, PET_series, outputpath);
            fprintf('Successfully output %s to "%s"\n', [studydir(jj).name, PET_series+".nii.gz"])
            % Determine CT directory (CT series, largest number of dcm)
            CTPointer = [0,0];
            for kk = 1:length(seriesdir)
                seriespath = fullfile(source, datedir(ii).name, studydir(jj).name, seriesdir(kk).name);
                dcmdir = dir(seriespath);
                dcm1name = fullfile(seriespath, dcmdir(3).name);
                info = dicominfo(dcm1name);
                if info.Modality == "CT" && length(dcmdir)>100
                    CT_series = seriesdir(kk).name;
                    CT_sourcename = fullfile(seriesdir(1).folder, CT_series);
                    CT_targetname = fullfile(outputpath, CT_series)+".nii";
                    dcm2nii_output(CT_sourcename, CT_series, outputpath);
                    fprintf('Successfully output %s to "%s"\n', [studydir(jj).name, CT_series+".nii.gz"])
%                     if length(dcmdir)>CTPointer(2)
%                         CTPointer = [kk, length(dcmdir)];
%                     end
                end
            end
%             CT_series = seriesdir(CTPointer(1)).name;
%             CT_sourcename = fullfile(seriesdir(1).folder, CT_series);
%             CT_targetname = fullfile(outputpath, CT_series)+".nii";
%             dcm2nii_output(CT_sourcename, CT_series, outputpath);
%             fprintf('Successfully output %s to "%s"\n', [studydir(jj).name, CT_series+".nii.gz"])
        elseif sum(startsWith({seriesdir.name}, {'CT WB'}))>0
            fprintf('The scanner for "%s" is Siemens \n', studydir(jj).name)
            PET_series_dir = seriesdir;
            PET_series_dir(~(startsWith({PET_series_dir.name}, {'PET WB'}))) = [];
            if length(PET_series_dir) == 1
                PET_series = PET_series_dir.name;
            else
                error('Unable to determine Siemens PET in %s', studypath)
            end
            PET_sourcename = fullfile(PET_series_dir(1).folder, PET_series);
            PET_targetname = fullfile(outputpath, PET_series)+".nii";
            dcm2nii_output(PET_sourcename, PET_series, outputpath);
            fprintf('Successfully output %s to "%s"\n', [studydir(jj).name, PET_series+".nii.gz"])
            CT_series_dir = seriesdir;
            CT_series_dir(~(startsWith({CT_series_dir.name}, {'CT WB'}))) = [];
            if length(CT_series_dir) == 1
                CT_series = CT_series_dir.name;
            else
                error('Unable to determine Siemens PET in %s', studypath)
            end
            CT_sourcename = fullfile(seriesdir(1).folder, CT_series);
            CT_targetname = fullfile(outputpath, CT_series)+".nii";
            dcm2nii_output(CT_sourcename, CT_series, outputpath);
            fprintf('Successfully output %s to "%s"\n', [studydir(jj).name, CT_series+".nii.gz"])
        else
            error('Unable to determine scanner type of %s', studypath)
        end
    end
end

function dcm2nii_output(input, output_name, output_folder)
% inputdir = dir(input);
% inputdir(ismember({inputdir.name},{'.', '..'}))=[];
% info = dicominfo(fullfile(input, inputdir(1).name));
% rows = info.Rows;
% columns = info.Columns;
% slicenum = length(inputdir);
% volume = zeros(rows, columns, slicenum);
% for ii = 1:slicenum
%     volume(:,:,ii) = dicomread(fullfile(input, inputdir(ii).name));
% end
% niftiwrite(volume, output)
command = strcat('D:\"OneDrive - pku.edu.cn"\Program\Research-Scripts\Dicom\PackNII\dcm2niix.exe -z y -f "' , char(output_name) ,'" -o "', char(output_folder) , '" "', input ,'"');
system(command);
%delete(fullfile(output_folder, output_name+".json"))
end