processing-java --sketch=%cd%/src/%1 --output=%cd%/src/%1/output --force --run
rmdir /S /Q %cd%\src\%1\output
