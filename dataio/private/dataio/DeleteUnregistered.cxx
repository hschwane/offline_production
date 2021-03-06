/**
 *  $Id: DeleteUnregistered.cxx 175992 2019-10-09 19:53:43Z olivas $
 *  
 *  Copyright (C) 2007, 2008, 2009
 *  Troy Straszheim <troy@icecube.umd.edu>
 *  and the IceCube Collaboration <http://www.icecube.wisc.edu>
 *  
 *  This file is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 3 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>
 *  
 */
 
#include <icetray/I3Context.h>
#include <icetray/I3DefaultName.h>
#include <icetray/I3Frame.h>
#include <icetray/I3Logging.h>
#include <icetray/I3Module.h>
#include <archive/archive_exception.hpp>

using namespace std;

class DeleteUnregistered : public I3Module
{
 public:

  DeleteUnregistered(const I3Context& context);

  virtual ~DeleteUnregistered();
  void Process();

 private:

  DeleteUnregistered(const DeleteUnregistered&);
  DeleteUnregistered& operator=(const DeleteUnregistered&);

  SET_LOGGER("DeleteUnregistered");
};


I3_MODULE(DeleteUnregistered);


DeleteUnregistered::DeleteUnregistered(const I3Context& context)
  : I3Module(context)
{}

DeleteUnregistered::~DeleteUnregistered() 
{ }

void DeleteUnregistered::Process()
{
  I3FramePtr frame = PopFrame();
  
  vector<string> deleteme;
  for (I3Frame::typename_iterator iter = frame->typename_begin();
       iter != frame->typename_end();
       iter++){
    I3FrameObjectConstPtr fop = frame->Get<I3FrameObjectConstPtr>(iter->first);
    if(!fop && frame->Has(iter->first))
       deleteme.push_back(iter->first);
  }
  for (unsigned i=0; i<deleteme.size(); i++)
    frame->Delete(deleteme[i]);
  PushFrame(frame); 
}


