%function [DCF, Confidence, ColorTransformation, AlignedReference] = nrdc(Source, Reference, [options])
%
%This is a beta implementation of the NRDC (Non-Rigid Dense Correspondence)
%algorithm described in the SIGGRAPH 2011 paper "Non-Rigid Dense
%Correspondence with Applications for Image Enhancement".
%THIS BETA WILL BE EXPIRED IN AUGUST 2012.
%
%Input RGB images Source and Reference of type double with pixel values 
%between zero and one.
%
%options is an optional parameter.
%options can have the following field:
%
%options.isParallelized - true (default) or false. If true, the algorithm is
% non deterministic, but faster.
%
%options.gainMin        = [0.2, 1,  1,  0.5     ]; % Lower edge of gain
%range per L, a, b, ||Dx+Dy|| channel.
%
%options.gainMax        = [3,   1,  1,  2       ]; % Higher edge of gain
%range per L, a, b, ||Dx+Dy|| channel.
%
%options.biasMin        = [-30, -20,-20,-0      ]; % Lower edge of bias
%range per L, a, b, ||Dx+Dy|| channel.
%
%options.biasMax        = [20,  20, 20, 0       ]; % Higher edge of bias
%range per L, a, b, ||Dx+Dy|| channel.
%
%options.logScaleRange  = [log(0.33),       log(3)        ]; Log(scale)
%range
%
%options.rotationRange  = [toRadians(-45),  toRadians(45) ]; Rotation
%range.

%------------------------------------------------------------------------%
% This software is distributed for free for non-commercial use only.
% Copyright (c) 2011 Yoav HaCohen.
% 
% This software is provided by the copyright holders and the contributors 
% ``as is'' and any express or implied warranties, including, but not limited 
% to, the implied warranties of merchantability and fitness for a particular 
% purpose are disclaimed. In no event shall the copyright holders or 
% contributors be liable for any direct, indirect, incidental, special, 
% exemplary, or consequential damages (including, but not limited to, 
% procurement of substitute goods or services; loss of use, data, or profits;
% or business interruption) however caused and on any theory of liability, 
% whether in contract, strict liability, or tort (including negligence or 
% otherwise) arising in any way out of the use of this software, even if 
% advised of the possibility of such damage.
%
% The views and conclusions contained in the software and documentation are 
% those of the authors and should not be interpreted as representing official 
% policies, either expressed or implied, of Yoav HaCohen.
%
%% Citation:
%   @article{NRDC2011,
%    author  = {Yoav HaCohen and Eli Shechtman and Dan B Goldman and Dani Lischinski},
%    title   = {Non-Rigid Dense Correspondence with Applications for Image Enhancement},
%    journal = {ACM Transactions on Graphics (Proceedings of ACM SIGGRAPH 2011)},
%    year    = {2011},
%    volume  = {30},
%    number  = {4},
%    pages   = {70:1--70:9}
%   }
%   http://www.cs.huji.ac.il/labs/cglab/projects/nrdc/
% Main contact: yoav.hacohen@mail.huji.ac.il (Yoav)
%
%% Version: 0.3, 12-August-2012: Release notes
% - Performance improvement
% - Supports a constraint per pixel input.
%
%% Previous versions:
%
% Version: 0.2, 04-November-2011: Release notes
% - Performance improvement
% - Bug fixes
% - The function returns empty array if no correspondence pixels have been found
%
% Version: 0.1, 04-August-2011: 
% First draft
%------------------------------------------------------------------------%

